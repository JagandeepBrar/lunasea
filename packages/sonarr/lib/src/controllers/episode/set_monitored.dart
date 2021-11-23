part of sonarr_commands;

Future<List<SonarrEpisode>> _commandEpisodeSetMonitored(
  Dio client, {
  required List<int> episodeIds,
  required bool monitored,
}) async {
  Response response = await client.put('episode/monitor', data: {
    'episodeIds': episodeIds,
    'monitored': monitored,
  });
  return (response.data as List)
      .map((episode) => SonarrEpisode.fromJson(episode))
      .toList();
}
