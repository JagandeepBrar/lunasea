part of sonarr_commands;

Future<SonarrSeries> _commandGetSeries(
  Dio client, {
  required int seriesId,
  bool includeSeasonImages = false,
}) async {
  Response response = await client.get('series/$seriesId', queryParameters: {
    'includeSeasonImages': includeSeasonImages,
  });
  return SonarrSeries.fromJson(response.data);
}
