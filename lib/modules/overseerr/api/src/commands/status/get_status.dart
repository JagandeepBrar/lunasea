part of overseerr_commands;

Future<OverseerrStatus> _commandGetStatus(Dio client) async {
  Response response = await client.get('status');
  return OverseerrStatus.fromJson(response.data);
}
