part of tautulli_commands;

Future<Map<String, dynamic>?> _commandDocs(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'docs',
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
