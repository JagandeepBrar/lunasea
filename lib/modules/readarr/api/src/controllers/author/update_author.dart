part of readarr_commands;

Future<ReadarrAuthor> _commandUpdateAuthor(
  Dio client, {
  required ReadarrAuthor author,
}) async {
  Response response = await client.put('author', data: author.toJson());
  return ReadarrAuthor.fromJson(response.data);
}
