part of sonarr_commands;

Future<SonarrCommand> _commandEpisodeSearch(Dio client, {
    required List<int> episodeIds,
}) async {
    Response response = await client.post('command', data: {
        'name': 'EpisodeSearch',
        'episodeIds': episodeIds,
    });
    return SonarrCommand.fromJson(response.data);
}
