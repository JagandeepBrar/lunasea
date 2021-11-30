part of sonarr_commands;

Future<void> _commandDeleteQueue(
  Dio client, {
  required int id,
  bool? removeFromClient,
  bool? blocklist,
}) async {
  await client.delete('queue/$id', queryParameters: {
    if (removeFromClient != null) 'removeFromClient': removeFromClient,
    if (blocklist != null) 'blocklist': blocklist,
  });
}
