part of sonarr_commands;

Future<List<SonarrQueueRecord>> _commandGetQueueDetails(
  Dio client, {
  int? seriesId,
  List<int>? episodeIds,
  bool? includeSeries,
  bool? includeEpisode,
}) async {
  Response response = await client.get('queue/details', queryParameters: {
    if (episodeIds != null) 'episodeIds': episodeIds,
    if (seriesId != null) 'seriesId': seriesId,
    if (includeSeries != null) 'includeSeries': includeSeries,
    if (includeEpisode != null) 'includeEpisode': includeEpisode,
  });
  return (response.data as List)
      .map((series) => SonarrQueueRecord.fromJson(series))
      .toList();
}
