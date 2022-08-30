part of tautulli_commands;

Future<void> _commandTerminateSession(
  Dio client, {
  required int? sessionKey,
  required String? sessionId,
  String? message,
}) async {
  if (sessionKey != null)
    assert(
        sessionId == null, 'sessionKey and sessionId both cannot be defined.');
  if (sessionKey == null)
    assert(sessionId != null, 'sessionKey and sessionId cannot both be null.');
  if (sessionId == null)
    assert(sessionKey != null, 'sessionKey and sessionId cannot both be null.');
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'terminate_session',
      if (sessionKey != null) 'session_key': sessionKey,
      if (sessionId != null) 'session_id': sessionId,
      if (message != null) 'message': message,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return;
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
