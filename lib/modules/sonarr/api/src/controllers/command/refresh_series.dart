part of sonarr_commands;

Future<SonarrCommand> _commandRefreshSeries(Dio client, {
    int? seriesId,
}) async {
    Response response = await client.post('command', data: {
        'name': 'RefreshSeries',
        if(seriesId != null) 'seriesId': seriesId,
    });
    return SonarrCommand.fromJson(response.data);
}
