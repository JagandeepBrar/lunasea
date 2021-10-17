part of sonarr_commands;

Future<List<SonarrEpisode>> _commandGetEpisodes(
  Dio client, {
  int? seriesId,
  int? seasonNumber,
  List<int>? episodeIds,
  int? episodeFileId,
  bool? includeImages,
}) async {
  Response response = await client.get('episode', queryParameters: {
    if (seriesId != null) 'seriesId': seriesId,
    if (seasonNumber != null) 'seasonNumber': seasonNumber,
    if (episodeIds != null) 'episodeIds': episodeIds,
    if (episodeFileId != null) 'episodeFileId': episodeFileId,
    if (includeImages != null) 'includeImages': includeImages,
  });
  return (response.data as List)
      .map((episode) => SonarrEpisode.fromJson(episode))
      .toList();
}
