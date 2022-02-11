part of readarr_commands;

Future<ReadarrCommand> _commandSeasonSearch(
  Dio client, {
  required int authorId,
  required int seasonNumber,
}) async {
  Response response = await client.post('command', data: {
    'name': 'SeasonSearch',
    'authorId': authorId,
    'seasonNumber': seasonNumber,
  });
  return ReadarrCommand.fromJson(response.data);
}
