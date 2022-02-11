part of readarr_commands;

Future<List<ReadarrRelease>> _commandGetAuthorReleases(
  Dio client, {
  required int authorId,
}) async {
  Response response = await client.get('release', queryParameters: {
    'authorId': authorId,
  });
  return (response.data as List)
      .map((series) => ReadarrRelease.fromJson(series))
      .toList();
}
