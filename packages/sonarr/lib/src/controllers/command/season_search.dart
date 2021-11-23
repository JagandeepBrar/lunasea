part of sonarr_commands;

Future<SonarrCommand> _commandSeasonSearch(Dio client, {
    required int seriesId,
    required int seasonNumber,
}) async {
    Response response = await client.post('command', data: {
        'name': 'SeasonSearch',
        'seriesId': seriesId,
        'seasonNumber': seasonNumber,
    });
    return SonarrCommand.fromJson(response.data);
}
