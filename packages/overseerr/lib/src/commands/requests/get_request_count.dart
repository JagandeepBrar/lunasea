part of overseerr_commands;

Future<OverseerrRequestCount> _commandGetRequestCount(Dio client) async {
  Response response = await client.get('request/count');
  return OverseerrRequestCount.fromJson(response.data);
}
