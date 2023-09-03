part of sonarr_commands;

Future<SonarrCommand> _commandManualImport(
    Dio client,
    List<SonarrQueueRecord> records
    ) async {
  Response response = await client.post('command', data: {
    'name': 'ManualImport',
    'files': records
  });
  return SonarrCommand.fromJson(response.data);
}
