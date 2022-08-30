part of radarr_commands;

Future<RadarrCommand> _commandRefreshMonitoredDownloads(Dio client) async {
  Response response = await client.post('command', data: {
    'name': 'RefreshMonitoredDownloads',
  });
  return RadarrCommand.fromJson(response.data);
}
