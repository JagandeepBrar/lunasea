part of radarr_commands;

Future<List<RadarrLanguage>> _commandGetAllLanguages(Dio client) async {
  Response response = await client.get('language');
  return (response.data as List)
      .map((profile) => RadarrLanguage.fromJson(profile))
      .toList();
}
