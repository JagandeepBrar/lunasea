part of readarr_commands;

Future<List<ReadarrQualityProfile>> _commandGetQualityProfiles(
  Dio client,
) async {
  Response response = await client.get('qualityprofile');
  return (response.data as List)
      .map((profile) => ReadarrQualityProfile.fromJson(profile))
      .toList();
}
