part of sonarr_commands;

Future<List<SonarrSeries>> _commandGetAllSeries(
  Dio client, {
  bool includeSeasonImages = false,
}) async {
  Response response = await client.get('series', queryParameters: {
    'includeSeasonImages': includeSeasonImages,
  });
  return (response.data as List)
      .map((series) => SonarrSeries.fromJson(series))
      .toList();
}
