part of radarr_commands;

Future<RadarrHistory> _commandGetHistory(
  Dio client, {
  int? page,
  int? pageSize,
  RadarrSortDirection? sortDirection,
  RadarrHistorySortKey? sortKey,
}) async {
  Response response = await client.get('history', queryParameters: {
    if (page != null) 'page': page,
    if (pageSize != null) 'pageSize': pageSize,
    if (sortDirection != null) 'sortDirection': sortDirection.value,
    if (sortKey != null) 'sortKey': sortKey.value,
  });
  return RadarrHistory.fromJson(response.data);
}
