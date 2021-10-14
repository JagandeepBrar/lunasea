part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to root folders within Sonarr.
/// 
/// [SonarrCommandHandler_RootFolder] internally handles routing the HTTP client to the API calls.
class SonarrCommandHandler_RootFolder {
    final Dio _client;

    /// Create a series command handler using an initialized [Dio] client.
    SonarrCommandHandler_RootFolder(this._client);

    /// Handler for [rootfolder](https://github.com/Sonarr/Sonarr/wiki/Rootfolder#get).
    /// 
    /// Returns a list of root folders.
    Future<List<SonarrRootFolder>> getRootFolders() async => _commandGetRootFolders(_client);
}
