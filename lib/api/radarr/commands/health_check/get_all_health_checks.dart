part of radarr_commands;

Future<List<RadarrHealthCheck>> _commandGetAllHealthChecks(Dio client) async {
  Response response = await client.get('health');
  return (response.data as List)
      .map((health) => RadarrHealthCheck.fromJson(health))
      .toList();
}
