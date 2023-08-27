part of sonarr_commands;

Future<SonarrMissing> _commandGetMissing(
  Dio client, {
  SonarrSortDirection? sortDirection,
  SonarrWantedMissingSortKey? sortKey,
  int? page,
  int? pageSize,
  bool? includeSeries,
  bool? includeImages,
}) async {
  Response response = await client.get('wanted/missing', queryParameters: {
    if (sortDirection != null) 'sortDirection': sortDirection.value,
    if (sortKey != null) 'sortKey': sortKey.value,
    if (page != null) 'page': page,
    if (pageSize != null) 'pageSize': pageSize,
    if (includeSeries != null) 'includeSeries': includeSeries,
    if (includeImages != null) 'includeImages': includeImages,
  });
  return SonarrMissing.fromJson(response.data);
}
