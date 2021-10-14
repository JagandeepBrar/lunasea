part of sonarr_commands;

Future<SonarrEpisode> _commandGetEpisode(Dio client, {
    required int episodeId,
}) async {
    Response response = await client.get('episode/${episodeId}');
    return SonarrEpisode.fromJson(response.data);
}
