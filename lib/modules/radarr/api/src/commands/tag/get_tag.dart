part of radarr_commands;

Future<RadarrTag> _commandGetTag(
  Dio client, {
  required int id,
}) async {
  Response response = await client.get('tag/$id');
  return RadarrTag.fromJson(response.data);
}
