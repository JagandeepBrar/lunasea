part of radarr_commands;

Future<List<RadarrMovie>> _commandGetMovieLookup(
  Dio client, {
  required String term,
}) async {
  Response response = await client.get('movie/lookup', queryParameters: {
    'term': term,
  });
  return (response.data as List)
      .map((lookup) => RadarrMovie.fromJson(lookup))
      .toList();
}
