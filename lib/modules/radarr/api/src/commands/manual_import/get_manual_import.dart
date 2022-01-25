part of radarr_commands;

Future<List<RadarrManualImport>> _commandGetManualImport(
  Dio client, {
  required String folder,
  bool? filterExistingFiles,
}) async {
  Response response = await client.get('manualimport', queryParameters: {
    'folder': folder,
    if (filterExistingFiles != null) 'filterExistingFiles': filterExistingFiles,
  });
  return (response.data as List)
      .map((import) => RadarrManualImport.fromJson(import))
      .toList();
}
