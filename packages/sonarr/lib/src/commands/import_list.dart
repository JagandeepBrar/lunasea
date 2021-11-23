part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to import lists within Sonarr.
///
/// [SonarrCommandHandler_ImportList] internally handles routing the HTTP client to the API calls.
class SonarrCommandHandler_ImportList {
  final Dio _client;

  /// Create an import list command handler using an initialized [Dio] client.
  SonarrCommandHandler_ImportList(this._client);

  Future<List<SonarrExclusion>> getExclusionList() async =>
      _commandGetExclusionList(_client);
}
