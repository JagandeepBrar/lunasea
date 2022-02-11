part of readarr_commands;

Future<ReadarrCommand> _commandRSSSync(Dio client) async {
  Response response = await client.post('command', data: {
    'name': 'RssSync',
  });
  return ReadarrCommand.fromJson(response.data);
}
