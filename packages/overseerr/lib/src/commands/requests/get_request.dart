part of overseerr_commands;

Future<OverseerrRequest> _commandGetRequest(
  Dio client, {
  required int id,
}) async {
  Response response = await client.get('request/$id');
  return OverseerrRequest.fromJson(response.data);
}
