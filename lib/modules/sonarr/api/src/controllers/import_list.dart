part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to import lists within Sonarr.
///
/// [SonarrControllerImportList] internally handles routing the HTTP client to the API calls.
class SonarrControllerImportList {
  final Dio _client;

  /// Create an import list command handler using an initialized [Dio] client.
  SonarrControllerImportList(this._client);

  Future<List<SonarrExclusion>> get() async =>
      _commandGetExclusionList(_client);
}
