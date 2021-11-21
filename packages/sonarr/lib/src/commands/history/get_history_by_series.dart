part of sonarr_commands;

Future<List<SonarrHistoryRecord>> _commandGetHistoryBySeries(
  Dio client, {
  required int seriesId,
  int? seasonNumber,
  bool? includeSeries,
  bool? includeEpisode,
}) async {
  Response response = await client.get('history/series', queryParameters: {
    'seriesId': seriesId,
    if (seasonNumber != null) 'seasonNumber': seasonNumber,
    if (includeSeries != null) 'includeSeries': includeSeries,
    if (includeEpisode != null) 'includeEpisode': includeEpisode,
  });
  return (response.data as List)
      .map((series) => SonarrHistoryRecord.fromJson(series))
      .toList();
}
