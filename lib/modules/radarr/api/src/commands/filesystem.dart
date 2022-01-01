part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to the filesystem from Radarr.
///
/// [RadarrCommandHandlerFileSystem] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandlerFileSystem {
  final Dio _client;

  /// Create a command handler using an initialized [Dio] client.
  RadarrCommandHandlerFileSystem(this._client);

  /// Handler for `filesystem`.
  ///
  /// Returns a list of directories and files in the supplied path.
  /// If no path is supplied, fetches the root directory of the OS.
  ///
  /// - `path`: The full path on the filesystem
  /// - `allowFoldersWithoutTrailingSlashes`: Go into a folders without trailing slashes
  /// - `includeFiles`: Include files in the folder (defaulted to false)
  Future<RadarrFileSystem> get({
    String? path,
    bool? allowFoldersWithoutTrailingSlashes,
    bool? includeFiles,
  }) async =>
      _commandGetFileSystem(
        _client,
        path: path,
        allowFoldersWithoutTrailingSlashes: allowFoldersWithoutTrailingSlashes,
        includeFiles: includeFiles,
      );

  /// Handler for `diskspace`.
  ///
  /// Returns a list of all disks and space information for the disks.
  Future<List<RadarrDiskSpace>> getDiskSpace() async =>
      _commandGetAllDiskSpaces(_client);
}
