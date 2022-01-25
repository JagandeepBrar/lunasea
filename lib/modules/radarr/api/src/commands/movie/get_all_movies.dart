part of radarr_commands;

Future<List<RadarrMovie>> _commandGetAllMovies(Dio client) async {
  Response response = await client.get('movie');
  return (response.data as List)
      .map((series) => RadarrMovie.fromJson(series))
      .toList();
}
