part of radarr_commands;

Future<List<RadarrHistoryRecord>> _commandGetMovieHistory(
  Dio client, {
  required int movieId,
}) async {
  Response response = await client.get('history/movie', queryParameters: {
    'movieId': movieId,
  });
  return (response.data as List)
      .map((file) => RadarrHistoryRecord.fromJson(file))
      .toList();
}
