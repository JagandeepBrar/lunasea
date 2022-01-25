part of radarr_commands;

Future<void> _commandPushRelease(
  Dio client, {
  required String guid,
  required int indexerId,
}) async {
  await client.post('release', data: {
    'guid': guid,
    'indexerId': indexerId,
  });
}
