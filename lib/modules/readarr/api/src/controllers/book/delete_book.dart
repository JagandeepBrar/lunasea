part of readarr_commands;

Future<void> _commandDeleteBook(
  Dio client, {
  required int bookId,
  bool deleteFiles = false,
  bool addImportListExclusion = false,
}) async {
  await client.delete('book/$bookId', queryParameters: {
    'deleteFiles': deleteFiles,
    'addImportListExclusion': addImportListExclusion,
  });
}
