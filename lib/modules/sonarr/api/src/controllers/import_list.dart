part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to import lists within Sonarr.
///
/// [SonarrController_ImportList] internally handles routing the HTTP client to the API calls.
class SonarrController_ImportList {
  final Dio _client;

  /// Create an import list command handler using an initialized [Dio] client.
  SonarrController_ImportList(this._client);

  Future<List<SonarrExclusion>> get() async =>
      _commandGetExclusionList(_client);
}
