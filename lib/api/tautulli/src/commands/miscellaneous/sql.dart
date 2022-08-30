part of tautulli_commands;

Future<void> _commandSql(
  Dio client, {
  required String query,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'sql',
      'query': query,
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
