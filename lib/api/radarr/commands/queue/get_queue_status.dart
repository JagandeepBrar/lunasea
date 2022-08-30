part of radarr_commands;

Future<RadarrQueueStatus> _commandGetQueueStatus(Dio client) async {
  Response response = await client.get('queue/status');
  return RadarrQueueStatus.fromJson(response.data);
}
