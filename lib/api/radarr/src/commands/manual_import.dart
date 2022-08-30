part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to manual import within Radarr.
///
/// [RadarrCommandHandlerManualImport] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandlerManualImport {
  final Dio _client;

  /// Create a command handler using an initialized [Dio] client.
  RadarrCommandHandlerManualImport(this._client);

  /// Handler for `manualimport`.
  ///
  /// Returns a list of potential files to manually import at the given path.
  ///
  /// Required Parameters:
  /// - `folder`: Full, absolute path to the folder to scan.
  ///
  /// Optional Parameters:
  /// - `filterExistingFiles`: If the scan should ignore/filter out existing files in Radarr.
  Future<List<RadarrManualImport>> get({
    required String folder,
    bool? filterExistingFiles,
  }) async =>
      _commandGetManualImport(_client,
          folder: folder, filterExistingFiles: filterExistingFiles);

  /// Handler for `manualimport`.
  ///
  /// Returns the updated information and rejections for a manual import.
  ///
  /// Required Parameters:
  /// - `data`: Array of [RadarrManualImportUpdateData] objects that each contain a single manual import to update.
  Future<List<RadarrManualImportUpdate>> update({
    required List<RadarrManualImportUpdateData> data,
  }) async =>
      _commandUpdateManualImport(_client, data: data);
}
