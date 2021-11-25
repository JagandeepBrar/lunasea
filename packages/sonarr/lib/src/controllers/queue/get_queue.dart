part of sonarr_commands;

Future<SonarrQueue> _commandGetQueue(
  Dio client, {
  bool? includeUnknownSeriesItems,
  bool? includeSeries,
  bool? includeEpisode,
}) async {
  Response response = await client.get('queue', queryParameters: {
    if (includeUnknownSeriesItems != null)
      'includeUnknownSeriesItems': includeUnknownSeriesItems,
    if (includeSeries != null) 'includeSeries': includeSeries,
    if (includeEpisode != null) 'includeEpisode': includeEpisode,
  });
  return SonarrQueue.fromJson(response.data);
}
