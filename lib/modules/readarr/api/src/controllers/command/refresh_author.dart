part of readarr_commands;

Future<ReadarrCommand> _commandRefreshAuthor(
  Dio client, {
  int? authorId,
}) async {
  Response response = await client.post('command', data: {
    'name': 'RefreshAuthor',
    if (authorId != null) 'authorId': authorId,
  });
  return ReadarrCommand.fromJson(response.data);
}
