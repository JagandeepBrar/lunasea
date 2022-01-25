part of tautulli_commands;

Future<List<TautulliServer>> _commandGetServerList(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_server_list',
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return (response.data['response']['data'] as List)
          .map((server) => TautulliServer.fromJson(server))
          .toList();
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
