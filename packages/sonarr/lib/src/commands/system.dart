part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to system within Sonarr.
/// 
/// [SonarrCommandHandler_System] internally handles routing the HTTP client to the API calls.
class SonarrCommandHandler_System {
    final Dio _client;

    /// Create a series command handler using an initialized [Dio] client.
    SonarrCommandHandler_System(this._client);

    /// Handler for [system/status](https://github.com/Sonarr/Sonarr/wiki/System-Status#get).
    /// 
    /// Returns system status information.
    Future<SonarrStatus> getStatus() async => _commandGetStatus(_client);
}
