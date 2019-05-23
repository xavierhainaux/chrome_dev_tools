import 'dart:async';
import 'package:meta/meta.dart' show required;
import '../src/connection.dart';
import 'network.dart' as network;
import 'service_worker.dart' as service_worker;

/// Defines events for background web platform features.
class BackgroundServiceApi {
  final Client _client;

  BackgroundServiceApi(this._client);

  /// Called when the recording state for the service has been updated.
  Stream<RecordingStateChangedEvent> get onRecordingStateChanged =>
      _client.onEvent
          .where((Event event) =>
              event.name == 'BackgroundService.recordingStateChanged')
          .map((Event event) =>
              RecordingStateChangedEvent.fromJson(event.parameters));

  /// Called with all existing backgroundServiceEvents when enabled, and all new
  /// events afterwards if enabled and recording.
  Stream<BackgroundServiceEvent> get onBackgroundServiceEventReceived => _client
      .onEvent
      .where((Event event) =>
          event.name == 'BackgroundService.backgroundServiceEventReceived')
      .map((Event event) => BackgroundServiceEvent.fromJson(
          event.parameters['backgroundServiceEvent']));

  /// Enables event updates for the service.
  Future<void> startObserving(ServiceName service) async {
    var parameters = <String, dynamic>{
      'service': service.toJson(),
    };
    await _client.send('BackgroundService.startObserving', parameters);
  }

  /// Disables event updates for the service.
  Future<void> stopObserving(ServiceName service) async {
    var parameters = <String, dynamic>{
      'service': service.toJson(),
    };
    await _client.send('BackgroundService.stopObserving', parameters);
  }

  /// Set the recording state for the service.
  Future<void> setRecording(bool shouldRecord, ServiceName service) async {
    var parameters = <String, dynamic>{
      'shouldRecord': shouldRecord,
      'service': service.toJson(),
    };
    await _client.send('BackgroundService.setRecording', parameters);
  }

  /// Clears all stored data for the service.
  Future<void> clearEvents(ServiceName service) async {
    var parameters = <String, dynamic>{
      'service': service.toJson(),
    };
    await _client.send('BackgroundService.clearEvents', parameters);
  }
}

class RecordingStateChangedEvent {
  final bool isRecording;

  final ServiceName service;

  RecordingStateChangedEvent(
      {@required this.isRecording, @required this.service});

  factory RecordingStateChangedEvent.fromJson(Map<String, dynamic> json) {
    return RecordingStateChangedEvent(
      isRecording: json['isRecording'],
      service: ServiceName.fromJson(json['service']),
    );
  }
}

/// The Background Service that will be associated with the commands/events.
/// Every Background Service operates independently, but they share the same
/// API.
class ServiceName {
  static const backgroundFetch = ServiceName._('backgroundFetch');
  static const backgroundSync = ServiceName._('backgroundSync');
  static const pushMessaging = ServiceName._('pushMessaging');
  static const notifications = ServiceName._('notifications');
  static const values = {
    'backgroundFetch': backgroundFetch,
    'backgroundSync': backgroundSync,
    'pushMessaging': pushMessaging,
    'notifications': notifications,
  };

  final String value;

  const ServiceName._(this.value);

  factory ServiceName.fromJson(String value) => values[value];

  String toJson() => value;

  @override
  bool operator ==(other) =>
      (other is ServiceName && other.value == value) || value == other;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value.toString();
}

/// A key-value pair for additional event information to pass along.
class EventMetadata {
  final String key;

  final String value;

  EventMetadata({@required this.key, @required this.value});

  factory EventMetadata.fromJson(Map<String, dynamic> json) {
    return EventMetadata(
      key: json['key'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{
      'key': key,
      'value': value,
    };
    return json;
  }
}

class BackgroundServiceEvent {
  /// Timestamp of the event (in seconds).
  final network.TimeSinceEpoch timestamp;

  /// The origin this event belongs to.
  final String origin;

  /// The Service Worker ID that initiated the event.
  final service_worker.RegistrationID serviceWorkerRegistrationId;

  /// The Background Service this event belongs to.
  final ServiceName service;

  /// A description of the event.
  final String eventName;

  /// An identifier that groups related events together.
  final String instanceId;

  /// A list of event-specific information.
  final List<EventMetadata> eventMetadata;

  BackgroundServiceEvent(
      {@required this.timestamp,
      @required this.origin,
      @required this.serviceWorkerRegistrationId,
      @required this.service,
      @required this.eventName,
      @required this.instanceId,
      @required this.eventMetadata});

  factory BackgroundServiceEvent.fromJson(Map<String, dynamic> json) {
    return BackgroundServiceEvent(
      timestamp: network.TimeSinceEpoch.fromJson(json['timestamp']),
      origin: json['origin'],
      serviceWorkerRegistrationId: service_worker.RegistrationID.fromJson(
          json['serviceWorkerRegistrationId']),
      service: ServiceName.fromJson(json['service']),
      eventName: json['eventName'],
      instanceId: json['instanceId'],
      eventMetadata: (json['eventMetadata'] as List)
          .map((e) => EventMetadata.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{
      'timestamp': timestamp.toJson(),
      'origin': origin,
      'serviceWorkerRegistrationId': serviceWorkerRegistrationId.toJson(),
      'service': service.toJson(),
      'eventName': eventName,
      'instanceId': instanceId,
      'eventMetadata': eventMetadata.map((e) => e.toJson()).toList(),
    };
    return json;
  }
}
