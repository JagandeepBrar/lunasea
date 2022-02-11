part of readarr_commands;

Future<ReadarrCommand> _commandBookSearch(
  Dio client, {
  required List<int> bookIds,
}) async {
  Response response = await client.post('command', data: {
    'name': 'BookSearch',
    'bookIds': bookIds,
  });
  return ReadarrCommand.fromJson(response.data);
}
