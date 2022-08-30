part of radarr_commands;

Future<RadarrQueue> _commandGetQueue(
  Dio client, {
  int page = 1,
  int pageSize = 20,
  RadarrSortDirection sortDirection = RadarrSortDirection.DESCENDING,
  RadarrQueueSortKey sortKey = RadarrQueueSortKey.PROGRESS,
  bool includeUnknownMovieItems = false,
}) async {
  Response response = await client.get('queue', queryParameters: {
    'page': page,
    'pageSize': pageSize,
    'sortDirection': sortDirection.value,
    'sortKey': sortKey.value,
    'includeUnknownMovieItems': includeUnknownMovieItems,
  });
  return RadarrQueue.fromJson(response.data);
}
