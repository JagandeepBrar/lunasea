part of sonarr_commands;

Future<SonarrCommand> _commandMissingEpisodeSearch(Dio client) async {
    Response response = await client.post('command', data: {
        'name': 'missingEpisodeSearch',
    });
    return SonarrCommand.fromJson(response.data);
}
