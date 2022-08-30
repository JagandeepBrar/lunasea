part of sonarr_commands;

Future<SonarrHistoryPage> _commandGetHistory(
  Dio client, {
  SonarrHistorySortKey? sortKey,
  int? page,
  int? pageSize,
  SonarrSortDirection? sortDirection,
  int? episodeId,
  String? downloadId,
  bool? includeSeries,
  bool? includeEpisode,
}) async {
  Response response = await client.get('history', queryParameters: {
    if (sortKey != null) 'sortKey': sortKey.value,
    if (page != null) 'page': page,
    if (pageSize != null) 'pageSize': pageSize,
    if (sortDirection != null) 'sortDirection': sortDirection.value,
    if (episodeId != null) 'episodeId': episodeId,
    if (downloadId != null) 'downloadId': downloadId,
    if (includeSeries != null) 'includeSeries': includeSeries,
    if (includeEpisode != null) 'includeEpisode': includeEpisode,
  });
  return SonarrHistoryPage.fromJson(response.data);
}
