part of readarr_commands;

Future<ReadarrTag> _commandAddTag(
  Dio client, {
  required String label,
}) async {
  Response response = await client.post('tag', data: {
    'label': label,
  });
  return ReadarrTag.fromJson(response.data);
}
