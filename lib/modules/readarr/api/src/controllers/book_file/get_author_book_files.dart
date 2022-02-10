part of readarr_commands;

Future<List<ReadarrBookFile>> _commandGetAuthorBookFiles(
  Dio client, {
  required int authorId,
}) async {
  Response response = await client.get('bookFile', queryParameters: {
    'authorId': authorId,
  });
  return (response.data as List)
      .map((episode) => ReadarrBookFile.fromJson(episode))
      .toList();
}
