part of sonarr_commands;

Future<SonarrEpisode> _commandUpdateEpisode(Dio client, {
    required SonarrEpisode episode,
}) async {
    Response response = await client.put('episode', data: episode.toJson());
    return SonarrEpisode.fromJson(response.data);
}
