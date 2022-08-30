part of tautulli_commands;

Future<String?> _commandStatus(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'status',
      'check': 'database',
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return response.data['response']['message'];
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
