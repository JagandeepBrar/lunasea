part of radarr_commands;

Future<List<RadarrQualityProfile>> _commandGetAllQualityProfiles(
    Dio client) async {
  Response response = await client.get('qualityprofile');
  return (response.data as List)
      .map((profile) => RadarrQualityProfile.fromJson(profile))
      .toList();
}
