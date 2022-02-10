part of readarr_commands;

Future<ReadarrCommand> _commandAuthorSearch(
  Dio client, {
  required int authorId,
}) async {
  Response response = await client.post('command', data: {
    'name': 'AuthorSearch',
    'authorId': authorId,
  });
  return ReadarrCommand.fromJson(response.data);
}
