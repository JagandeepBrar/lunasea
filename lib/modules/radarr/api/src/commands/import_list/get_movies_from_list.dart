part of radarr_commands;

Future<List<RadarrMovie>> _commandGetImportListMovies(
  Dio client, {
  bool? includeRecommendations,
}) async {
  Response response = await client.get('importlist/movie', queryParameters: {
    if (includeRecommendations != null)
      'includeRecommendations': includeRecommendations,
  });
  return (response.data as List)
      .map((movie) => RadarrMovie.fromJson(movie))
      .toList();
}
