part of radarr_commands;

Future<List<RadarrExclusion>> _commandGetAllExclusions(Dio client) async {
  Response response = await client.get('exclusions');
  return (response.data as List)
      .map((exclusion) => RadarrExclusion.fromJson(exclusion))
      .toList();
}
