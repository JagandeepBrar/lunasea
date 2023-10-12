part of sonarr_commands;

Future<SonarrCommand> _commandManualImport(
    Dio client,
    List<SonarrManualImport> manualImports
    ) async {
  Response response = await client.post('command', data: {
    'name': 'ManualImport',
    'files': manualImports,
    'importMode': 'auto'
  });
  return SonarrCommand.fromJson(response.data);
}
