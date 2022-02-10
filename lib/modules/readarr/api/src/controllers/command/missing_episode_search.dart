part of readarr_commands;

Future<ReadarrCommand> _commandMissingBooksSearch(Dio client) async {
  Response response = await client.post('command', data: {
    'name': 'missingBookSearch',
  });
  return ReadarrCommand.fromJson(response.data);
}
