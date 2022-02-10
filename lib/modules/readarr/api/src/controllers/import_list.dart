part of readarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to import lists within Readarr.
///
/// [ReadarrControllerImportList] internally handles routing the HTTP client to the API calls.
class ReadarrControllerImportList {
  final Dio _client;

  /// Create an import list command handler using an initialized [Dio] client.
  ReadarrControllerImportList(this._client);

  Future<List<ReadarrExclusion>> get() async =>
      _commandGetExclusionList(_client);
}
