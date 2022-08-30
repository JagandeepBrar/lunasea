part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to quality profiles within Radarr.
///
/// [RadarrCommandHandlerQualityProfile] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandlerQualityProfile {
  final Dio _client;

  /// Create a command handler using an initialized [Dio] client.
  RadarrCommandHandlerQualityProfile(this._client);

  /// Handler for `qualitydefinition`.
  ///
  /// Returns all quality definitions.
  Future<List<RadarrQualityDefinition>> getDefinitions() async =>
      _commandGetQualityDefinitions(_client);

  /// Handler for [qualityprofile/{id}](https://radarr.video/docs/api/#/Quality/get-add-discover).
  ///
  /// Returns a single quality profile.
  ///
  /// Required Parameters:
  /// - `profileId`: Quality profile identifier
  Future<RadarrQualityProfile> get({required int profileId}) async =>
      _commandGetQualityProfile(_client, profileId: profileId);

  /// Handler for [qualityprofile](https://radarr.video/docs/api/#/Quality/get-add-discover).
  ///
  /// Returns all quality profiles.
  Future<List<RadarrQualityProfile>> getAll() async =>
      _commandGetAllQualityProfiles(_client);
}
