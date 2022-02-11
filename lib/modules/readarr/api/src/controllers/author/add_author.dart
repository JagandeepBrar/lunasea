part of readarr_commands;

Future<ReadarrAuthor> _commandAddAuthor(
  Dio client, {
  required ReadarrAuthor author,
  required ReadarrQualityProfile qualityProfile,
  required ReadarrMetadataProfile metadataProfile,
  required ReadarrRootFolder rootFolder,
  required ReadarrAuthorMonitorType monitorType,
  List<ReadarrTag> tags = const [],
  bool searchForMissingEpisodes = false,
  bool searchForCutoffUnmetEpisodes = false,
}) async {
  Map<String, dynamic> _payload = author.toJson();
  _payload.addAll({
    'monitored': true,
    'qualityProfileId': qualityProfile.id,
    'metadataProfileId': metadataProfile.id,
    'tags': tags.map((tag) => tag.id).toList(),
    'rootFolderPath': rootFolder.path,
    'addOptions': {
      'monitor': monitorType.value,
      'searchForMissingEpisodes': searchForMissingEpisodes,
      'searchForCutoffUnmetEpisodes': searchForCutoffUnmetEpisodes,
    },
  });
  Response response = await client.post('author', data: _payload);
  return ReadarrAuthor.fromJson(response.data);
}
