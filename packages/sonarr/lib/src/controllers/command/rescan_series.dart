part of sonarr_commands;

Future<SonarrCommand> _commandRescanSeries(Dio client, {
    int? seriesId,
}) async {
    Response response = await client.post('command', data: {
        'name': 'RescanSeries',
        if(seriesId != null) 'seriesId': seriesId,
    });
    return SonarrCommand.fromJson(response.data);
}
