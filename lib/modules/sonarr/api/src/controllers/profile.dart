part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to profiles within Sonarr.
///
/// [SonarrControllerProfile] internally handles routing the HTTP client to the API calls.
class SonarrControllerProfile {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  SonarrControllerProfile(this._client);

  /// Handler for [profile](https://github.com/Sonarr/Sonarr/wiki/Profile#get).
  ///
  /// Returns a list of all quality profiles.
  Future<List<SonarrQualityProfile>> getQualityProfiles() async =>
      _commandGetQualityProfiles(_client);

  /// Handler for [language profile](https://github.com/Sonarr/Sonarr/wiki/Profile#get).
  ///
  /// Returns a list of all language profiles.
  Future<List<SonarrLanguageProfile>> getLanguageProfiles() async =>
      _commandGetLanguageProfiles(_client);
}
