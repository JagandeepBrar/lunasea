part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to root folders within Radarr.
/// 
/// [RadarrCommandHandler_RootFolder] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandler_RootFolder {
    final Dio _client;

    /// Create a command handler using an initialized [Dio] client.
    RadarrCommandHandler_RootFolder(this._client);

    /// Handler for `rootfolder`.
    /// 
    /// Returns a list of root folders.
    Future<List<RadarrRootFolder>> get() async => _commandGetRootFolders(_client);
}
