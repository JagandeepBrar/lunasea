part of readarr_commands;

Future<ReadarrQueue> _commandGetQueue(
  Dio client, {
  bool? includeUnknownAuthorItems,
  bool? includeAuthor,
  bool? includeBook,
  ReadarrSortDirection? sortDirection,
  ReadarrQueueSortKey? sortKey,
  int? page,
  int? pageSize,
}) async {
  Response response = await client.get('queue', queryParameters: {
    if (includeUnknownAuthorItems != null)
      'includeUnknownAuthorItems': includeUnknownAuthorItems,
    if (includeAuthor != null) 'includeAuthor': includeAuthor,
    if (includeBook != null) 'includeBook': includeBook,
    if (sortDirection != null) 'sortDirection': sortDirection.value,
    if (sortKey != null) 'sortKey': sortKey.value,
    if (page != null) 'page': pageSize,
    if (pageSize != null) 'pageSize': pageSize,
  });
  return ReadarrQueue.fromJson(response.data);
}
