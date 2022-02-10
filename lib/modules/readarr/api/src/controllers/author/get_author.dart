part of readarr_commands;

Future<ReadarrAuthor> _commandGetAuthor(
  Dio client, {
  required int authorId,
}) async {
  Response response = await client.get('author/$authorId');
  return ReadarrAuthor.fromJson(response.data);
}
