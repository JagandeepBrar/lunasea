part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to health checks within Radarr.
///
/// [RadarrCommandHandlerHealthCheck] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandlerHealthCheck {
  final Dio _client;

  /// Create a command handler using an initialized [Dio] client.
  RadarrCommandHandlerHealthCheck(this._client);

  /// Handler for `health`.
  ///
  /// Returns a list of health check messages.
  Future<List<RadarrHealthCheck>> get() async =>
      _commandGetAllHealthChecks(_client);
}
