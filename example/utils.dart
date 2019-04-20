/*import 'dart:async';
import 'dart:io';

import 'package:puppeteer/puppeteer.dart';
import 'package:puppeteer/chrome_downloader.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';
import 'package:path/path.dart' as p;

void setupLogger() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(print);
}

Future chromePage(Function(Page) callback) async {
  Chrome chrome = await Chrome.start();
  Page page = await chrome.newPage();

  try {
    await callback(page);
  } finally {
    await chrome.close();
  }
}

Future server(Function(String) callback) async {
  var handler = createStaticHandler('example');

  var host = 'localhost';
  HttpServer server = await io.serve(handler, host, 0);
  try {
    await callback('http://$host:${server.port}');
  } finally {
    await server.close();
  }
}

Future page(Function(Page, String hostUrl) callback) async {
  await server((String url) async {
    await chromePage((Page page) async {
      await callback(page, url);
    });
  });
}
*/
