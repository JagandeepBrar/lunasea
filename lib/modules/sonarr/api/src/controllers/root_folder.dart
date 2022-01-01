part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to root folders within Sonarr.
///
/// [SonarrController_RootFolder] internally handles routing the HTTP client to the API calls.
class SonarrController_RootFolder {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  SonarrController_RootFolder(this._client);

  /// Handler for [rootfolder](https://github.com/Sonarr/Sonarr/wiki/Rootfolder#get).
  ///
  /// Returns a list of root folders.
  Future<List<SonarrRootFolder>> get() async => _commandGetRootFolders(_client);
}
