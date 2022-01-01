part of sonarr_commands;

Future<SonarrSeries> _commandDeleteSeries(
  Dio client, {
  required int seriesId,
  bool deleteFiles = false,
  bool addImportListExclusion = false,
}) async {
  Response response = await client.delete('series/$seriesId', queryParameters: {
    'deleteFiles': deleteFiles,
    'addImportListExclusion': addImportListExclusion,
  });
  return SonarrSeries.fromJson(response.data);
}
