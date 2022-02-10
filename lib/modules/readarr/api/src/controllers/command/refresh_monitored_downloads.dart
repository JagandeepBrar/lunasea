part of readarr_commands;

Future<ReadarrCommand> _commandRefreshMonitoredDownloads(Dio client) async {
  Response response = await client.post('command', data: {
    'name': 'RefreshMonitoredDownloads',
  });
  return ReadarrCommand.fromJson(response.data);
}
