part of tautulli_commands;

Future<void> _commandBackupConfig(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'backup_config',
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
