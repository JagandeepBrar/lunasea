part of tautulli_commands;

Future<List<TautulliServerInfo>> _commandGetServersInfo(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_servers_info',
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return (response.data['response']['data'] as List)
          .map((server) => TautulliServerInfo.fromJson(server))
          .toList();
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
