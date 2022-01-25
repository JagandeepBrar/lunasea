part of tautulli_commands;

Future<List<TautulliUserName>> _commandGetUserNames(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_user_names',
    },
  );
  switch (response.data['response']['result']) {
    case 'success':
      return (response.data['response']['data'] as List)
          .map((library) => TautulliUserName.fromJson(library))
          .toList();
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
