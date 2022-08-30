part of sonarr_commands;

Future<SonarrCommand> _commandSeriesSearch(
  Dio client, {
  required int seriesId,
}) async {
  Response response = await client.post('command', data: {
    'name': 'SeriesSearch',
    'seriesId': seriesId,
  });
  return SonarrCommand.fromJson(response.data);
}
