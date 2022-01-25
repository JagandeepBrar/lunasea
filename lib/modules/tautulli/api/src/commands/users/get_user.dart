part of tautulli_commands;

Future<TautulliUser> _commandGetUser(
  Dio client, {
  required int userId,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_user',
      'user_id': userId,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return TautulliUser.fromJson(response.data['response']['data']);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
