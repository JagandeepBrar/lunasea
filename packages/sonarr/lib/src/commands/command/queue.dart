part of sonarr_commands;

Future<List<SonarrCommand>> _commandCommandQueue(Dio client) async {
    Response response = await client.get('command');
    return (response.data as List).map((command) => SonarrCommand.fromJson(command)).toList();
}
