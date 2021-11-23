part of sonarr_commands;

Future<SonarrQueue> _commandGetQueue(Dio client) async {
  Response response = await client.get('queue');
  return SonarrQueue.fromJson(response.data);
}
