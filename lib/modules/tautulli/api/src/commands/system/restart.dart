part of tautulli_commands;

Future<void> _commandRestart(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'restart',
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
