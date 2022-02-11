part of readarr_commands;

Future<List<ReadarrTag>> _commandGetAllTags(Dio client) async {
  Response response = await client.get('tag');
  return (response.data as List).map((tag) => ReadarrTag.fromJson(tag)).toList();
}
