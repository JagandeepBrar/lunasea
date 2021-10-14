part of sonarr_commands;

Future<List<SonarrEpisode>> _commandGetSeriesEpisodes(Dio client, {
    required int seriesId,
}) async {
    Response response = await client.get('episode', queryParameters: {
        'seriesId': seriesId,
    });
    return (response.data as List).map((episode) => SonarrEpisode.fromJson(episode)).toList();
}
