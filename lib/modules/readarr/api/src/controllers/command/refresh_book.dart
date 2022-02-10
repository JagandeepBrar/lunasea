part of readarr_commands;

Future<ReadarrCommand> _commandRefreshBook(
  Dio client, {
  int? bookId,
}) async {
  Response response = await client.post('command', data: {
    'name': 'RefreshBook',
    if (bookId != null) 'bookId': bookId,
  });
  return ReadarrCommand.fromJson(response.data);
}
