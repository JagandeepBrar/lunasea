part of readarr_commands;

Future<List<ReadarrBookFile>> _commandGetBookFile(
  Dio client, {
  required int bookId,
}) async {
  Response response = await client.get('bookFile', queryParameters: {
    'bookId': bookId,
  });
  return (response.data as List)
      .map((episode) => ReadarrBookFile.fromJson(episode))
      .toList();
}
