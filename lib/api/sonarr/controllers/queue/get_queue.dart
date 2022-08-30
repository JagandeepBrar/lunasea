part of sonarr_commands;

Future<SonarrQueuePage> _commandGetQueue(
  Dio client, {
  bool? includeUnknownSeriesItems,
  bool? includeSeries,
  bool? includeEpisode,
  SonarrSortDirection? sortDirection,
  SonarrQueueSortKey? sortKey,
  int? page,
  int? pageSize,
}) async {
  Response response = await client.get('queue', queryParameters: {
    if (includeUnknownSeriesItems != null)
      'includeUnknownSeriesItems': includeUnknownSeriesItems,
    if (includeSeries != null) 'includeSeries': includeSeries,
    if (includeEpisode != null) 'includeEpisode': includeEpisode,
    if (sortDirection != null) 'sortDirection': sortDirection.value,
    if (sortKey != null) 'sortKey': sortKey.value,
    if (page != null) 'page': pageSize,
    if (pageSize != null) 'pageSize': pageSize,
  });
  return SonarrQueuePage.fromJson(response.data);
}
