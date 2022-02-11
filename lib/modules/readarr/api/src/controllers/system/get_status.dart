part of readarr_commands;

Future<ReadarrStatus> _commandGetStatus(Dio client) async {
  Response response = await client.get('system/status');
  return ReadarrStatus.fromJson(response.data);
}
