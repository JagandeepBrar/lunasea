part of radarr_commands;

Future<RadarrCommand> _commandManualImport(
  Dio client, {
  required List<RadarrManualImportFile> files,
  required RadarrImportMode importMode,
}) async {
  assert(
    files.isNotEmpty,
    'Files must contain at least one RadarrManualImportFile',
  );
  Response response = await client.post('command', data: {
    'name': 'ManualImport',
    'files': files.map((file) => file.toJson()).toList(),
    'importMode': importMode.value,
  });
  return RadarrCommand.fromJson(response.data);
}
