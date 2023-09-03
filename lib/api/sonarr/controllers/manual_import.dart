part of sonarr_commands;

/// Sends a request to import a queued item within Sonarr.
///
/// [SonarrControllerManualImport] internally handles routing the HTTP client to the API calls.
class SonarrControllerManualImport {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  SonarrControllerManualImport(this._client);

  /// Handler for [manualimport]
  ///
  /// Sends a request to manually import a queued item with warnings.
  ///
  /// Required Parameters:
  /// - `records`: The records to import
  Future<void> import({
    required List<SonarrQueueRecord> records
  }) async =>
      _commandManualImport(_client, records);
}
