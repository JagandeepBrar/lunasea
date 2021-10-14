part of sonarr_commands;

Future<List<SonarrRelease>> _commandGetReleases(Dio client, {
    required int episodeId,
}) async {
    Response response = await client.get('release', queryParameters: {
        'episodeId': episodeId,
    });
    return (response.data as List).map((series) => SonarrRelease.fromJson(series)).toList();
}
