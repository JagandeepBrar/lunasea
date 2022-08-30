part of tautulli_commands;

/// Facilitates, encapsulates, and manages individual calls related to activity within Tautulli.
///
/// [TautulliCommandHandlerActivity] internally handles routing the HTTP client to the API calls.
class TautulliCommandHandlerActivity {
  final Dio _client;

  /// Create an activity command handler using an initialized [Dio] client.
  TautulliCommandHandlerActivity(this._client);

  /// Handler for [delete_temp_sessions](https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_temp_sessions).
  ///
  /// Flush out all of the temporary sessions in the database.
  Future<void> deleteTempSessions() async =>
      _commandDeleteTempSessions(_client);

  /// Handler for [get_activity](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_activity).
  ///
  /// Get the current activity on the Plex Media Server.
  ///
  /// Optional Parameters:
  /// - `sessionKey`: Session key for the session info to return, **OR**
  /// - `sessionId`: Session ID for the session info to return
  Future<TautulliActivity?> getActivity({
    int? sessionKey,
    String? sessionId,
  }) async =>
      _commandGetActivity(_client,
          sessionKey: sessionKey, sessionId: sessionId);

  /// Handler for [terminate_session](https://github.com/Tautulli/Tautulli/blob/master/API.md#terminate_session).
  ///
  /// Stop a streaming session.
  ///
  /// Required Parameters:
  /// - `sessionKey`: Session key for the session info to terminate, **OR**
  /// - `sessionId`: Session ID for the session info to terminate
  ///
  /// Optional parameters:
  /// - `message`: Message to show user for reason of termination
  Future<void> terminateSession({
    int? sessionKey,
    String? sessionId,
    String? message,
  }) async =>
      _commandTerminateSession(_client,
          sessionKey: sessionKey, sessionId: sessionId, message: message);
}
