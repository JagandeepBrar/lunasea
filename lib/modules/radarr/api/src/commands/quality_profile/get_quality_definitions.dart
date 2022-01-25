part of radarr_commands;

Future<List<RadarrQualityDefinition>> _commandGetQualityDefinitions(
    Dio client) async {
  Response response = await client.get('qualitydefinition');
  return (response.data as List)
      .map((profile) => RadarrQualityDefinition.fromJson(profile))
      .toList();
}
