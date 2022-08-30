part of radarr_commands;

Future<List<RadarrRelease>> _commandGetReleases(
  Dio client, {
  required int movieId,
}) async {
  Response response = await client.get('release', queryParameters: {
    'movieId': movieId,
  });
  return (response.data as List)
      .map((release) => RadarrRelease.fromJson(release))
      .toList();
}
