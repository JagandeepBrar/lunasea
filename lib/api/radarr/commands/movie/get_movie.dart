part of radarr_commands;

Future<RadarrMovie> _commandGetMovie(
  Dio client, {
  required int movieId,
}) async {
  Response response = await client.get('movie/$movieId');
  return RadarrMovie.fromJson(response.data);
}
