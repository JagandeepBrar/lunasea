part of radarr_commands;

Future<RadarrCommand> _commandRefreshMovie(
  Dio client, {
  List<int>? movieIds,
}) async {
  Response response = await client.post('command', data: {
    'name': 'RefreshMovie',
    if (movieIds != null) 'movieIds': movieIds,
  });
  return RadarrCommand.fromJson(response.data);
}
