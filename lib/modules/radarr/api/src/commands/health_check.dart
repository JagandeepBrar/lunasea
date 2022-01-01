part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to health checks within Radarr.
/// 
/// [RadarrCommandHandler_HealthCheck] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandler_HealthCheck {
    final Dio _client;

    /// Create a command handler using an initialized [Dio] client.
    RadarrCommandHandler_HealthCheck(this._client);

    /// Handler for `health`.
    /// 
    /// Returns a list of health check messages.
    Future<List<RadarrHealthCheck>> get() async => _commandGetAllHealthChecks(_client);
}
