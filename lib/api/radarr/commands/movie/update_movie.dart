part of radarr_commands;

Future<RadarrMovie> _commandUpdateMovie(
  Dio client, {
  required RadarrMovie movie,
  required bool moveFiles,
}) async {
  Response response = await client.put(
    'movie',
    data: movie.toJson(),
    queryParameters: {
      'moveFiles': moveFiles,
    },
  );
  return RadarrMovie.fromJson(response.data);
}
