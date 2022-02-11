part of readarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to root folders within Readarr.
///
/// [ReadarrControllerRootFolder] internally handles routing the HTTP client to the API calls.
class ReadarrControllerRootFolder {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  ReadarrControllerRootFolder(this._client);

  /// Handler for [rootfolder](https://github.com/Readarr/Readarr/wiki/Rootfolder#get).
  ///
  /// Returns a list of root folders.
  Future<List<ReadarrRootFolder>> get() async => _commandGetRootFolders(_client);
}
