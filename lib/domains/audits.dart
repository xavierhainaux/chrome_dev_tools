import 'dart:async';
import 'package:meta/meta.dart' show required;
import '../src/connection.dart';
import 'network.dart' as network;

/// Audits domain allows investigation of page violations and possible improvements.
class AuditsApi {
  final Client _client;

  AuditsApi(this._client);

  /// Returns the response body and size if it were re-encoded with the specified settings. Only
  /// applies to images.
  /// [requestId] Identifier of the network request to get content for.
  /// [encoding] The encoding to use.
  /// [quality] The quality of the encoding (0-1). (defaults to 1)
  /// [sizeOnly] Whether to only return the size information (defaults to false).
  Future<GetEncodedResponseResult> getEncodedResponse(
    network.RequestId requestId,
    String encoding, {
    num quality,
    bool sizeOnly,
  }) async {
    Map parameters = {
      'requestId': requestId.toJson(),
      'encoding': encoding,
    };
    if (quality != null) {
      parameters['quality'] = quality;
    }
    if (sizeOnly != null) {
      parameters['sizeOnly'] = sizeOnly;
    }
    Map result = await _client.send('Audits.getEncodedResponse', parameters);
    return new GetEncodedResponseResult.fromJson(result);
  }
}

class GetEncodedResponseResult {
  /// The encoded body as a base64 string. Omitted if sizeOnly is true.
  final String body;

  /// Size before re-encoding.
  final int originalSize;

  /// Size after re-encoding.
  final int encodedSize;

  GetEncodedResponseResult({
    this.body,
    @required this.originalSize,
    @required this.encodedSize,
  });

  factory GetEncodedResponseResult.fromJson(Map json) {
    return new GetEncodedResponseResult(
      body: json.containsKey('body') ? json['body'] : null,
      originalSize: json['originalSize'],
      encodedSize: json['encodedSize'],
    );
  }
}
