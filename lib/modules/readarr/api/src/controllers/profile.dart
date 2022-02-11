part of readarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to profiles within Readarr.
///
/// [ReadarrControllerProfile] internally handles routing the HTTP client to the API calls.
class ReadarrControllerProfile {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  ReadarrControllerProfile(this._client);

  /// Handler for [profile](https://github.com/Readarr/Readarr/wiki/Profile#get).
  ///
  /// Returns a list of all quality profiles.
  Future<List<ReadarrQualityProfile>> getQualityProfiles() async =>
      _commandGetQualityProfiles(_client);

  /// Handler for [language profile](https://github.com/Readarr/Readarr/wiki/Profile#get).
  ///
  /// Returns a list of all language profiles.
  Future<List<ReadarrMetadataProfile>> getMetadataProfiles() async =>
      _commandGetMetadataProfiles(_client);
}
