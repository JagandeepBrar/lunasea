part of radarr_commands;

Future<void> _commandDeleteQueue(
  Dio client, {
  required int id,
  bool removeFromClient = false,
  bool blacklist = false,
}) async {
  await client.delete('queue/$id', queryParameters: {
    'removeFromClient': removeFromClient,
    'blacklist': blacklist,
  });
  return;
}
