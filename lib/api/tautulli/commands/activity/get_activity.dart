part of tautulli_commands;

Future<TautulliActivity?> _commandGetActivity(
  Dio client, {
  int? sessionKey,
  String? sessionId,
}) async {
  if (sessionKey != null)
    assert(
        sessionId == null, 'sessionKey and sessionId both cannot be defined.');
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_activity',
      if (sessionKey != null) 'session_key': sessionKey,
      if (sessionId != null) 'session_id': sessionId,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      if ((response.data['response']['data'] as Map).isEmpty) return null;
      return TautulliActivity.fromJson(response.data['response']['data']);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
