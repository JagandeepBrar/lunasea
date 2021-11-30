part of sonarr_commands;

Future<SonarrCommand> _commandRefreshMonitoredDownloads(Dio client) async {
    Response response = await client.post('command', data: {
        'name': 'RefreshMonitoredDownloads',
    });
    return SonarrCommand.fromJson(response.data);
}
