import 'dart:async';
import 'package:meta/meta.dart' show required;
import '../src/connection.dart';

class MemoryApi {
  final Client _client;

  MemoryApi(this._client);

  Future<GetDOMCountersResult> getDOMCounters() async {
    var result = await _client.send('Memory.getDOMCounters');
    return GetDOMCountersResult.fromJson(result);
  }

  Future prepareForLeakDetection() async {
    await _client.send('Memory.prepareForLeakDetection');
  }

  /// Enable/disable suppressing memory pressure notifications in all processes.
  /// [suppressed] If true, memory pressure notifications will be suppressed.
  Future setPressureNotificationsSuppressed(
    bool suppressed,
  ) async {
    var parameters = <String, dynamic>{
      'suppressed': suppressed,
    };
    await _client.send('Memory.setPressureNotificationsSuppressed', parameters);
  }

  /// Simulate a memory pressure notification in all processes.
  /// [level] Memory pressure level of the notification.
  Future simulatePressureNotification(
    PressureLevel level,
  ) async {
    var parameters = <String, dynamic>{
      'level': level.toJson(),
    };
    await _client.send('Memory.simulatePressureNotification', parameters);
  }

  /// Start collecting native memory profile.
  /// [samplingInterval] Average number of bytes between samples.
  /// [suppressRandomness] Do not randomize intervals between samples.
  Future startSampling({
    int samplingInterval,
    bool suppressRandomness,
  }) async {
    var parameters = <String, dynamic>{};
    if (samplingInterval != null) {
      parameters['samplingInterval'] = samplingInterval;
    }
    if (suppressRandomness != null) {
      parameters['suppressRandomness'] = suppressRandomness;
    }
    await _client.send('Memory.startSampling', parameters);
  }

  /// Stop collecting native memory profile.
  Future stopSampling() async {
    await _client.send('Memory.stopSampling');
  }

  /// Retrieve native memory allocations profile
  /// collected since renderer process startup.
  Future<SamplingProfile> getAllTimeSamplingProfile() async {
    var result = await _client.send('Memory.getAllTimeSamplingProfile');
    return SamplingProfile.fromJson(result['profile']);
  }

  /// Retrieve native memory allocations profile
  /// collected since browser process startup.
  Future<SamplingProfile> getBrowserSamplingProfile() async {
    var result = await _client.send('Memory.getBrowserSamplingProfile');
    return SamplingProfile.fromJson(result['profile']);
  }

  /// Retrieve native memory allocations profile collected since last
  /// `startSampling` call.
  Future<SamplingProfile> getSamplingProfile() async {
    var result = await _client.send('Memory.getSamplingProfile');
    return SamplingProfile.fromJson(result['profile']);
  }
}

class GetDOMCountersResult {
  final int documents;

  final int nodes;

  final int jsEventListeners;

  GetDOMCountersResult({
    @required this.documents,
    @required this.nodes,
    @required this.jsEventListeners,
  });

  factory GetDOMCountersResult.fromJson(Map<String, dynamic> json) {
    return GetDOMCountersResult(
      documents: json['documents'],
      nodes: json['nodes'],
      jsEventListeners: json['jsEventListeners'],
    );
  }
}

/// Memory pressure level.
class PressureLevel {
  static const PressureLevel moderate = const PressureLevel._('moderate');
  static const PressureLevel critical = const PressureLevel._('critical');
  static const values = const {
    'moderate': moderate,
    'critical': critical,
  };

  final String value;

  const PressureLevel._(this.value);

  factory PressureLevel.fromJson(String value) => values[value];

  String toJson() => value;

  @override
  String toString() => value.toString();
}

/// Heap profile sample.
class SamplingProfileNode {
  /// Size of the sampled allocation.
  final num size;

  /// Total bytes attributed to this sample.
  final num total;

  /// Execution stack at the point of allocation.
  final List<String> stack;

  SamplingProfileNode({
    @required this.size,
    @required this.total,
    @required this.stack,
  });

  factory SamplingProfileNode.fromJson(Map<String, dynamic> json) {
    return SamplingProfileNode(
      size: json['size'],
      total: json['total'],
      stack: (json['stack'] as List).map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{
      'size': size,
      'total': total,
      'stack': stack.map((e) => e).toList(),
    };
    return json;
  }
}

/// Array of heap profile samples.
class SamplingProfile {
  final List<SamplingProfileNode> samples;

  final List<Module> modules;

  SamplingProfile({
    @required this.samples,
    @required this.modules,
  });

  factory SamplingProfile.fromJson(Map<String, dynamic> json) {
    return SamplingProfile(
      samples: (json['samples'] as List)
          .map((e) => SamplingProfileNode.fromJson(e))
          .toList(),
      modules:
          (json['modules'] as List).map((e) => Module.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{
      'samples': samples.map((e) => e.toJson()).toList(),
      'modules': modules.map((e) => e.toJson()).toList(),
    };
    return json;
  }
}

/// Executable module information
class Module {
  /// Name of the module.
  final String name;

  /// UUID of the module.
  final String uuid;

  /// Base address where the module is loaded into memory. Encoded as a decimal
  /// or hexadecimal (0x prefixed) string.
  final String baseAddress;

  /// Size of the module in bytes.
  final num size;

  Module({
    @required this.name,
    @required this.uuid,
    @required this.baseAddress,
    @required this.size,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      name: json['name'],
      uuid: json['uuid'],
      baseAddress: json['baseAddress'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    var json = <String, dynamic>{
      'name': name,
      'uuid': uuid,
      'baseAddress': baseAddress,
      'size': size,
    };
    return json;
  }
}
