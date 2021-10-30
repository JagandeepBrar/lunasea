part of sonarr_commands;

Future<List<SonarrHistoryRecord>> _commandGetHistoryBySeries(
  Dio client, {
  required int seriesId,
  int? seasonNumber,
}) async {
  Response response = await client.get('history/series', queryParameters: {
    'seriesId': seriesId,
    if (seasonNumber != null) 'seasonNumber': seasonNumber,
  });
  return (response.data as List)
      .map((series) => SonarrHistoryRecord.fromJson(series))
      .toList();
}
