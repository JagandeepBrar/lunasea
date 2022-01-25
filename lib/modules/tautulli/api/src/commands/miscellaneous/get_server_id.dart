part of tautulli_commands;

Future<String?> _commandGetServerID(
  Dio client, {
  required String hostname,
  required int port,
  bool? ssl,
  bool? remote,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_server_id',
      'hostname': hostname,
      'port': port,
      if (ssl != null) 'ssl': ssl ? 1 : 0,
      if (remote != null) 'remote': remote ? 1 : 0,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return response.data['response']['data']['identifier'];
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
