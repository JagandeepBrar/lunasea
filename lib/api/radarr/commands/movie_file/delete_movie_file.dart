part of radarr_commands;

Future<void> _commandDeleteMovieFile(
  Dio client, {
  required int movieFileId,
}) async {
  await client.delete('moviefile/$movieFileId');
  return;
}
