part of overseerr_commands;

Future<OverseerrStatusAppData> _commandGetStatusAppData(Dio client) async {
  Response response = await client.get('status/appdata');
  return OverseerrStatusAppData.fromJson(response.data);
}
