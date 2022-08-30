part of radarr_commands;

Future<RadarrCommand> _commandMissingMovieSearch(Dio client) async {
  Response response = await client.post('command', data: {
    'name': 'MissingMoviesSearch',
  });
  return RadarrCommand.fromJson(response.data);
}
