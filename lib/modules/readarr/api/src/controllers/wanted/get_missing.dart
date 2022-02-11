part of readarr_commands;

Future<ReadarrMissing> _commandGetMissing(
  Dio client, {
  ReadarrSortDirection? sortDir,
  ReadarrWantedMissingSortKey? sortKey,
  int? page,
  int? pageSize,
  bool? includeSeries,
  bool? includeImages,
}) async {
  Response response = await client.get('wanted/missing', queryParameters: {
    if (sortDir != null) 'sortDir': sortDir.value,
    if (sortKey != null) 'sortKey': sortKey.value,
    if (page != null) 'page': page,
    if (pageSize != null) 'pageSize': pageSize,
    if (includeSeries != null) 'includeSeries': includeSeries,
    if (includeImages != null) 'includeImages': includeImages,
  });
  return ReadarrMissing.fromJson(response.data);
}
