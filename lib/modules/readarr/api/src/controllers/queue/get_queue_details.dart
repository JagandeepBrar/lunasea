part of readarr_commands;

Future<List<ReadarrQueueRecord>> _commandGetQueueDetails(
  Dio client, {
  int? authorId,
  List<int>? bookIds,
  bool? includeAuthor,
  bool? includeBook,
}) async {
  Response response = await client.get('queue/details', queryParameters: {
    if (bookIds != null) 'bookIds': bookIds,
    if (authorId != null) 'authorId': authorId,
    if (includeAuthor != null) 'includeAuthor': includeAuthor,
    if (includeBook != null) 'includeBook': includeBook,
  });
  return (response.data as List)
      .map((series) => ReadarrQueueRecord.fromJson(series))
      .toList();
}
