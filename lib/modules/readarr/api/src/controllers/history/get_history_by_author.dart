part of readarr_commands;

Future<List<ReadarrHistoryRecord>> _commandGetHistoryByAuthor(
  Dio client, {
  required int authorId,
  int? bookId,
  bool? includeAuthor,
  bool? includeBook,
}) async {
  Response response = await client.get('history/author', queryParameters: {
    'authorId': authorId,
    if (bookId != null) 'bookId': bookId,
    if (includeAuthor != null) 'includeAuthor': includeAuthor,
    if (includeBook != null) 'includeBook': includeBook,
  });
  return (response.data as List)
      .map((series) => ReadarrHistoryRecord.fromJson(series))
      .toList();
}
