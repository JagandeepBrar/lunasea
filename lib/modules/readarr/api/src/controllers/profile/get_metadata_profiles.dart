part of readarr_commands;

Future<List<ReadarrMetadataProfile>> _commandGetMetadataProfiles(
  Dio client,
) async {
  Response response = await client.get('metadataprofile');
  return (response.data as List)
      .map((profile) => ReadarrMetadataProfile.fromJson(profile))
      .toList();
}
