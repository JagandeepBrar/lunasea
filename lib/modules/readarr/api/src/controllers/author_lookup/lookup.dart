part of readarr_commands;

Future<List<ReadarrAuthor>> _commandGetSeriesLookup(
  Dio client, {
  required String term,
}) async {
  Response response = await client.get('author/lookup', queryParameters: {
    'term': term,
  });
  return (response.data as List)
      .map((series) => ReadarrAuthor.fromJson(series))
      .toList();
}
