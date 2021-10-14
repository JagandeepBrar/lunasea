part of sonarr_commands;

Future<SonarrCommand> _commandBackup(Dio client) async {
    Response response = await client.post('command', data: {
        'name': 'Backup',
    });
    return SonarrCommand.fromJson(response.data);
}
