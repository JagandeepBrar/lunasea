part of tautulli_commands;

Future<void> _commandBackupDB(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'backup_db',
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
