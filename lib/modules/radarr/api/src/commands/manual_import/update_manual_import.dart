part of radarr_commands;

Future<List<RadarrManualImportUpdate>> _commandUpdateManualImport(
  Dio client, {
  required List<RadarrManualImportUpdateData> data,
}) async {
  Response response = await client.post(
    'manualimport',
    data: data.map<Map<dynamic, dynamic>>((data) => data.toJson()).toList(),
  );
  return (response.data as List)
      .map((import) => RadarrManualImportUpdate.fromJson(import))
      .toList();
}
