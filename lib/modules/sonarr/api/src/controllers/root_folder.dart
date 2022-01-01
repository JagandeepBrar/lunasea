part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to root folders within Sonarr.
///
/// [SonarrControllerRootFolder] internally handles routing the HTTP client to the API calls.
class SonarrControllerRootFolder {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  SonarrControllerRootFolder(this._client);

  /// Handler for [rootfolder](https://github.com/Sonarr/Sonarr/wiki/Rootfolder#get).
  ///
  /// Returns a list of root folders.
  Future<List<SonarrRootFolder>> get() async => _commandGetRootFolders(_client);
}
