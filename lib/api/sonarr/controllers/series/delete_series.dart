part of sonarr_commands;

Future<void> _commandDeleteSeries(
  Dio client, {
  required int seriesId,
  bool deleteFiles = false,
  bool addImportListExclusion = false,
}) async {
  await client.delete('series/$seriesId', queryParameters: {
    'deleteFiles': deleteFiles,
    'addImportListExclusion': addImportListExclusion,
  });
}
