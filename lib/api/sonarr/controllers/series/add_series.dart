part of sonarr_commands;

Future<SonarrSeries> _commandAddSeries(
  Dio client, {
  required SonarrSeries series,
  required SonarrSeriesType seriesType,
  required bool seasonFolder,
  required SonarrQualityProfile qualityProfile,
  required SonarrRootFolder rootFolder,
  required SonarrSeriesMonitorType monitorType,
  SonarrLanguageProfile? languageProfile,
  List<SonarrTag> tags = const [],
  bool searchForMissingEpisodes = false,
  bool searchForCutoffUnmetEpisodes = false,
}) async {
  Map<String, dynamic> _payload = series.toJson();
  _payload.addAll({
    'monitored': true,
    'qualityProfileId': qualityProfile.id,
    if (languageProfile != null) 'languageProfileId': languageProfile.id,
    'seasonFolder': seasonFolder,
    'seriesType': seriesType.value,
    'tags': tags.map((tag) => tag.id).toList(),
    'rootFolderPath': rootFolder.path,
    'addOptions': {
      'monitor': monitorType.value,
      'searchForMissingEpisodes': searchForMissingEpisodes,
      'searchForCutoffUnmetEpisodes': searchForCutoffUnmetEpisodes,
    },
  });
  Response response = await client.post('series', data: _payload);
  return SonarrSeries.fromJson(response.data);
}
