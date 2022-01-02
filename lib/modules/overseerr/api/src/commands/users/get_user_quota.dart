part of overseerr_commands;

Future<OverseerrUserQuota> _commandGetUserQuota(
  Dio client, {
  required int id,
}) async {
  Response response = await client.get('user/$id/quota');
  return OverseerrUserQuota.fromJson(response.data);
}
