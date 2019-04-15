import 'dart:async';
import 'package:meta/meta.dart' show required;
import '../src/connection.dart';

/// This domain provides experimental commands only supported in headless mode.
class HeadlessExperimentalApi {
  final Client _client;

  HeadlessExperimentalApi(this._client);

  /// Issued when the target starts or stops needing BeginFrames.
  Stream<bool> get onNeedsBeginFramesChanged => _client.onEvent
      .where((Event event) =>
          event.name == 'HeadlessExperimental.needsBeginFramesChanged')
      .map((Event event) => event.parameters['needsBeginFrames'] as bool);

  /// Sends a BeginFrame to the target and returns when the frame was completed. Optionally captures a
  /// screenshot from the resulting frame. Requires that the target was created with enabled
  /// BeginFrameControl. Designed for use with --run-all-compositor-stages-before-draw, see also
  /// https://goo.gl/3zHXhB for more background.
  /// [frameTimeTicks] Timestamp of this BeginFrame in Renderer TimeTicks (milliseconds of uptime). If not set,
  /// the current time will be used.
  /// [interval] The interval between BeginFrames that is reported to the compositor, in milliseconds.
  /// Defaults to a 60 frames/second interval, i.e. about 16.666 milliseconds.
  /// [noDisplayUpdates] Whether updates should not be committed and drawn onto the display. False by default. If
  /// true, only side effects of the BeginFrame will be run, such as layout and animations, but
  /// any visual updates may not be visible on the display or in screenshots.
  /// [screenshot] If set, a screenshot of the frame will be captured and returned in the response. Otherwise,
  /// no screenshot will be captured. Note that capturing a screenshot can fail, for example,
  /// during renderer initialization. In such a case, no screenshot data will be returned.
  Future<BeginFrameResult> beginFrame(
      {num frameTimeTicks,
      num interval,
      bool noDisplayUpdates,
      ScreenshotParams screenshot}) async {
    var parameters = <String, dynamic>{};
    if (frameTimeTicks != null) {
      parameters['frameTimeTicks'] = frameTimeTicks;
    }
    if (interval != null) {
      parameters['interval'] = interval;
    }
    if (noDisplayUpdates != null) {
      parameters['noDisplayUpdates'] = noDisplayUpdates;
    }
    if (screenshot != null) {
      parameters['screenshot'] = screenshot.toJson();
    }
    var result =
        await _client.send('HeadlessExperimental.beginFrame', parameters);
    return BeginFrameResult.fromJson(result);
  }

  /// Disables headless events for the target.
  Future disable() async {
    await _client.send('HeadlessExperimental.disable');
  }

  /// Enables headless events for the target.
  Future enable() async {
    await _client.send('HeadlessExperimental.enable');
  }
}

class BeginFrameResult {
  /// Whether the BeginFrame resulted in damage and, thus, a new frame was committed to the
  /// display. Reported for diagnostic uses, may be removed in the future.
  final bool hasDamage;

  /// Base64-encoded image data of the screenshot, if one was requested and successfully taken.
  final String screenshotData;

  BeginFrameResult({@required this.hasDamage, this.screenshotData});

  factory BeginFrameResult.fromJson(Map<String, dynamic> json) {
    return BeginFrameResult(
      hasDamage: json['hasDamage'],
      screenshotData:
          json.containsKey('screenshotData') ? json['screenshotData'] : null,
    );
  }
}

/// Encoding options for a screenshot.
class ScreenshotParams {
  /// Image compression format (defaults to png).
  final ScreenshotParamsFormat format;

  /// Compression quality from range [0..100] (jpeg only).
  final int quality;

  ScreenshotParams({this.format, this.quality});

  factory ScreenshotParams.fromJson(Map<String, dynamic> json) {
    return ScreenshotParams(
      format: json.containsKey('format')
          ? ScreenshotParamsFormat.fromJson(json['format'])
          : null,
      quality: json.containsKey('quality') ? json['quality'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{};
    if (format != null) {
      json['format'] = format;
    }
    if (quality != null) {
      json['quality'] = quality;
    }
    return json;
  }
}

class ScreenshotParamsFormat {
  static const ScreenshotParamsFormat jpeg =
      const ScreenshotParamsFormat._('jpeg');
  static const ScreenshotParamsFormat png =
      const ScreenshotParamsFormat._('png');
  static const values = const {
    'jpeg': jpeg,
    'png': png,
  };

  final String value;

  const ScreenshotParamsFormat._(this.value);

  factory ScreenshotParamsFormat.fromJson(String value) => values[value];

  String toJson() => value;

  @override
  bool operator ==(other) =>
      (other is ScreenshotParamsFormat && other.value == value) ||
      value == other;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value.toString();
}
