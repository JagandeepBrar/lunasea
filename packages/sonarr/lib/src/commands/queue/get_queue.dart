part of sonarr_commands;

Future<List<SonarrQueueRecord>> _commandGetQueue(Dio client) async {
    Response response = await client.get('queue');
    return (response.data as List).map((record) => SonarrQueueRecord.fromJson(record)).toList();
}
