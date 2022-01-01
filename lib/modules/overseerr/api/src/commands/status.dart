part of overseerr_commands;

/// Facilitates, encapsulates, and manages individual calls related to statuses within Overseerr.
///
/// [OverseerrCommandHandlerStatus] internally handles routing the HTTP client to the API calls.
class OverseerrCommandHandlerStatus {
  final Dio _client;

  /// Create a command handler using an initialized [Dio] client.
  OverseerrCommandHandlerStatus(this._client);

  /// Handler for [status](https://api-docs.overseerr.dev/#/public/get_status).
  ///
  /// Returns the current Overseerr version and commit hash.
  Future<OverseerrStatus> getStatus() async => _commandGetStatus(_client);

  /// Handler for [status/appdata](https://api-docs.overseerr.dev/#/public/get_status_appdata).
  ///
  /// For Docker installs, returns whether or not the volume mount was configured properly.
  /// Always returns true for non-Docker installs.
  Future<OverseerrStatusAppData> getAppData() async =>
      _commandGetStatusAppData(_client);
}
