part of overseerr_commands;

Future<OverseerrUser> _commandGetUser(
  Dio client, {
  required int id,
}) async {
  Response response = await client.get('user/$id');
  return OverseerrUser.fromJson(response.data);
}
