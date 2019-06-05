import 'dart:async';
import 'package:meta/meta.dart' show required;
import '../src/connection.dart';

/// A domain for interacting with Cast, Presentation API, and Remote Playback API
/// functionalities.
class CastApi {
  final Client _client;

  CastApi(this._client);

  /// This is fired whenever the list of available sinks changes. A sink is a
  /// device or a software surface that you can cast to.
  Stream<List<Sink>> get onSinksUpdated => _client.onEvent
      .where((event) => event.name == 'Cast.sinksUpdated')
      .map((event) => (event.parameters['sinks'] as List)
          .map((e) => Sink.fromJson(e))
          .toList());

  /// This is fired whenever the outstanding issue/error message changes.
  /// |issueMessage| is empty if there is no issue.
  Stream<String> get onIssueUpdated => _client.onEvent
      .where((event) => event.name == 'Cast.issueUpdated')
      .map((event) => event.parameters['issueMessage'] as String);

  /// Starts observing for sinks that can be used for tab mirroring, and if set,
  /// sinks compatible with |presentationUrl| as well. When sinks are found, a
  /// |sinksUpdated| event is fired.
  /// Also starts observing for issue messages. When an issue is added or removed,
  /// an |issueUpdated| event is fired.
  Future<void> enable({String presentationUrl}) async {
    var parameters = <String, dynamic>{};
    if (presentationUrl != null) {
      parameters['presentationUrl'] = presentationUrl;
    }
    await _client.send('Cast.enable', parameters);
  }

  /// Stops observing for sinks and issues.
  Future<void> disable() async {
    await _client.send('Cast.disable');
  }

  /// Sets a sink to be used when the web page requests the browser to choose a
  /// sink via Presentation API, Remote Playback API, or Cast SDK.
  Future<void> setSinkToUse(String sinkName) async {
    var parameters = <String, dynamic>{
      'sinkName': sinkName,
    };
    await _client.send('Cast.setSinkToUse', parameters);
  }

  /// Starts mirroring the tab to the sink.
  Future<void> startTabMirroring(String sinkName) async {
    var parameters = <String, dynamic>{
      'sinkName': sinkName,
    };
    await _client.send('Cast.startTabMirroring', parameters);
  }

  /// Stops the active Cast session on the sink.
  Future<void> stopCasting(String sinkName) async {
    var parameters = <String, dynamic>{
      'sinkName': sinkName,
    };
    await _client.send('Cast.stopCasting', parameters);
  }
}

class Sink {
  final String name;

  final String id;

  /// Text describing the current session. Present only if there is an active
  /// session on the sink.
  final String session;

  Sink({@required this.name, @required this.id, this.session});

  factory Sink.fromJson(Map<String, dynamic> json) {
    return Sink(
      name: json['name'],
      id: json['id'],
      session: json.containsKey('session') ? json['session'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{
      'name': name,
      'id': id,
    };
    if (session != null) {
      json['session'] = session;
    }
    return json;
  }
}
