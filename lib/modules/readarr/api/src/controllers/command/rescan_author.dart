part of readarr_commands;

Future<ReadarrCommand> _commandRescanSeries(
  Dio client, {
  int? authorId,
}) async {
  Response response = await client.post('command', data: {
    'name': 'RescanSeries',
    if (authorId != null) 'authorId': authorId,
  });
  return ReadarrCommand.fromJson(response.data);
}
