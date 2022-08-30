part of radarr_commands;

Future<List<RadarrMovieCredits>> _commandGetCredits(
  Dio client, {
  required int movieId,
}) async {
  Response response = await client.get('credit', queryParameters: {
    'movieId': movieId,
  });
  return (response.data as List)
      .map((credit) => RadarrMovieCredits.fromJson(credit))
      .toList();
}
