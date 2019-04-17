import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chrome_dev_tools/domains/browser.dart';
import 'package:chrome_dev_tools/domains/system_info.dart';
import 'package:chrome_dev_tools/src/page/page.dart';
import 'package:chrome_dev_tools/src/page/emulation_manager.dart';
import 'package:pool/pool.dart';

import '../domains/target.dart';
import 'package:chrome_dev_tools/src/connection.dart';
import 'tab.dart';
import 'package:logging/logging.dart';

final Logger _logger = Logger('chrome_dev_tools');

const List<String> _defaultArgs = <String>[
  '--disable-background-networking',
  '--enable-features=NetworkService,NetworkServiceInProcess',
  '--disable-background-timer-throttling',
  '--disable-backgrounding-occluded-windows',
  '--disable-breakpad',
  '--disable-client-side-phishing-detection',
  '--disable-default-apps',
  '--disable-dev-shm-usage',
  '--disable-extensions',
  '--disable-features=site-per-process,TranslateUI',
  '--disable-hang-monitor',
  '--disable-ipc-flooding-protection',
  '--disable-popup-blocking',
  '--disable-prompt-on-repost',
  '--disable-renderer-backgrounding',
  '--disable-sync',
  '--force-color-profile=srgb',
  '--disable-translate',
  '--metrics-recording-only',
  '--no-first-run',
  '--safebrowsing-disable-auto-update',
  '--enable-automation',
  '--password-store=basic',
  '--use-mock-keychain',
  '--remote-debugging-port=0',
];

const List<String> _headlessArgs = [
  '--headless',
  '--disable-gpu',
  '--hide-scrollbars',
  '--mute-audio'
];

class Chrome {
  final Process process;
  final Connection connection;
  final BrowserApi browser;
  final SystemInfoApi systemInfo;
  final Pool _screenshotsPool = Pool(1);
  final DeviceViewport defaultViewport;

  Chrome._(this.process, this.connection, {this.defaultViewport})
      : browser = BrowserApi(connection),
        systemInfo = SystemInfoApi(connection);

  static Future<Chrome> start(String chromeExecutable,
      {bool headless = true,
      bool useTemporaryUserData = false,
      bool noSandboxFlag,
      DeviceViewport defaultViewport}) async {
    // In docker environment we want to force the '--no-sandbox' flag automatically
    noSandboxFlag ??= Platform.environment['CHROME_FORCE_NO_SANDBOX'] == 'true';

    Directory userDataDir;
    if (useTemporaryUserData) {
      userDataDir = await Directory.systemTemp.createTemp('chrome_');
    }

    List<String> chromeArgs = _defaultArgs.toList();
    if (userDataDir != null) {
      chromeArgs.add('--user-data-dir=${userDataDir.path}');
    }

    if (headless) {
      chromeArgs.addAll(_headlessArgs);
    }
    if (noSandboxFlag) {
      chromeArgs.add('--no-sandbox');
    }

    _logger.info('Start $chromeExecutable with $chromeArgs');
    Process chromeProcess = await Process.start(chromeExecutable, chromeArgs);

    // ignore: unawaited_futures
    chromeProcess.exitCode.then((int exitCode) {
      _logger.info('Chrome exit with $exitCode.');
      if (userDataDir != null) {
        _logger.info('Clean ${userDataDir.path}');
        userDataDir.deleteSync(recursive: true);
      }
    });

    String webSocketUrl = await _waitForWebSocketUrl(chromeProcess);
    if (webSocketUrl != null) {
      Connection connection = await Connection.create(webSocketUrl);

      return Chrome._(chromeProcess, connection,
          defaultViewport: defaultViewport);
    } else {
      throw Exception('Not able to connect to Chrome DevTools');
    }
  }

  static final RegExp _devToolRegExp =
      RegExp(r'^DevTools listening on (ws:\/\/.*)$');

  static Future _waitForWebSocketUrl(Process chromeProcess) async {
    await for (String line in chromeProcess.stderr
        .transform(Utf8Decoder())
        .transform(LineSplitter())) {
      _logger.warning('[Chrome stderr]: $line');
      Match match = _devToolRegExp.firstMatch(line);
      if (match != null) {
        return match.group(1);
      }
    }
  }

  TargetApi get targetApi => connection.targetApi;

  Future<Tab> newTab({bool incognito = false}) async {
    BrowserContextID contextID;
    if (incognito) {
      contextID = await targetApi.createBrowserContext();
    }

    TargetID targetId = await targetApi.createTarget('about:blank',
        browserContextId: contextID);
    Session session =
        await connection.createSession(targetId, browserContextID: contextID);

    return Tab(this, targetId, session, browserContextID: contextID);
  }

  Future<Page> newPage(
      {bool incognito = false, DeviceViewport viewport}) async {
    Tab tab = await newTab(incognito: incognito);
    return Page.create(tab, viewport: viewport ?? defaultViewport);
  }

  Future closeAllTabs() async {
    for (TargetInfo target in await targetApi.getTargets()) {
      await targetApi.closeTarget(target.targetId);
    }
  }

  Future<int> close() {
    if (Platform.isWindows) {
      // Allow a clean exit on Windows.
      // With `process.kill`, it seems that chrome retain a lock on the user-data directory
      Process.runSync('taskkill', ['/pid', process.pid.toString(), '/T', '/F']);
    } else {
      process.kill(ProcessSignal.sigint);
    }

    return process.exitCode;
  }
}

Pool screenshotPool(Chrome browser) => browser._screenshotsPool;