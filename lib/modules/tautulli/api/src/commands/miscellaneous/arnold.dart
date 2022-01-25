part of tautulli_commands;

Future<String?> _commandArnold(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'arnold',
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return response.data['response']['data'];
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
