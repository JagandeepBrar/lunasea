part of readarr_commands;

Future<ReadarrCommand> _commandBackup(Dio client) async {
  Response response = await client.post('command', data: {
    'name': 'Backup',
  });
  return ReadarrCommand.fromJson(response.data);
}
