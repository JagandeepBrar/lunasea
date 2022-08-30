part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to root folders within Radarr.
///
/// [RadarrCommandHandlerRootFolder] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandlerRootFolder {
  final Dio _client;

  /// Create a command handler using an initialized [Dio] client.
  RadarrCommandHandlerRootFolder(this._client);

  /// Handler for `rootfolder`.
  ///
  /// Returns a list of root folders.
  Future<List<RadarrRootFolder>> get() async => _commandGetRootFolders(_client);
}
