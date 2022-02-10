part of readarr_commands;

Future<ReadarrTag> _commandGetTag(
  Dio client, {
  required int id,
}) async {
  Response response = await client.get('tag/$id');
  return ReadarrTag.fromJson(response.data);
}
