part of tautulli_commands;

Future<List<TautulliUser>> _commandGetUsers(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_users',
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return (response.data['response']['data'] as List)
          .map((user) => TautulliUser.fromJson(user))
          .toList();
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
