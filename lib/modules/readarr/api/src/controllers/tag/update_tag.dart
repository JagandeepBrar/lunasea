part of readarr_commands;

Future<ReadarrTag> _commandUpdateTag(
  Dio client, {
  required ReadarrTag tag,
}) async {
  Response response = await client.put('tag', data: tag.toJson());
  return ReadarrTag.fromJson(response.data);
}
