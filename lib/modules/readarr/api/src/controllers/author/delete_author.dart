part of readarr_commands;

Future<void> _commandDeleteAuthor(
  Dio client, {
  required int authorId,
  bool deleteFiles = false,
  bool addImportListExclusion = false,
}) async {
  await client.delete('author/$authorId', queryParameters: {
    'deleteFiles': deleteFiles,
    'addImportListExclusion': addImportListExclusion,
  });
}
