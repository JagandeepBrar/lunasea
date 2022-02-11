part of readarr_commands;

Future<List<ReadarrRelease>> _commandGetReleases(
  Dio client, {
  required int bookId,
}) async {
  Response response = await client.get('release', queryParameters: {
    'bookId': bookId,
  });
  return (response.data as List)
      .map((series) => ReadarrRelease.fromJson(series))
      .toList();
}
