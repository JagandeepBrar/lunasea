part of tautulli_commands;

Future<TautulliServerIdentity> _commandGetServerIdentity(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_server_identity',
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return TautulliServerIdentity.fromJson(response.data['response']['data']);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
