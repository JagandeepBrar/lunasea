part of sonarr_commands;

Future<List<SonarrQualityProfile>> _commandGetQualityProfiles(Dio client) async {
    Response response = await client.get('profile');
    return (response.data as List).map((profile) => SonarrQualityProfile.fromJson(profile)).toList();
}
