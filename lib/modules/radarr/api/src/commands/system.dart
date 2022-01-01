part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to the system within Radarr.
/// 
/// [RadarrCommandHandler_System] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandler_System {
    final Dio _client;

    /// Create a command handler using an initialized [Dio] client.
    RadarrCommandHandler_System(this._client);

    /// Handler for `system/status`.
    /// 
    /// Returns details about the installtion/system.
    Future<RadarrSystemStatus> status() async => _commandGetSystemStatus(_client);
}
