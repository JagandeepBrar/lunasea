part of readarr_commands;

Future<ReadarrHistory> _commandGetHistory(
  Dio client, {
  ReadarrHistorySortKey? sortKey,
  int? page,
  int? pageSize,
  ReadarrSortDirection? sortDirection,
  int? bookId,
  String? downloadId,
  bool? includeAuthor,
  bool? includeBook,
}) async {
  Response response = await client.get('history', queryParameters: {
    if (sortKey != null) 'sortKey': sortKey.value,
    if (page != null) 'page': page,
    if (pageSize != null) 'pageSize': pageSize,
    if (sortDirection != null) 'sortDirection': sortDirection.value,
    if (bookId != null) 'bookId': bookId,
    if (downloadId != null) 'downloadId': downloadId,
    if (includeAuthor != null) 'includeAuthor': includeAuthor,
    if (includeBook != null) 'includeBook': includeBook,
  });
  return ReadarrHistory.fromJson(response.data);
}
