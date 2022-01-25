part of radarr_commands;

Future<RadarrCommand> _commandMoviesSearch(
  Dio client, {
  required List<int> movieIds,
}) async {
  Response response = await client.post('command', data: {
    'name': 'MoviesSearch',
    'movieIds': movieIds,
  });
  return RadarrCommand.fromJson(response.data);
}
