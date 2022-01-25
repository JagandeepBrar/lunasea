part of tautulli_commands;

Future<List<TautulliRecentlyAdded>> _commandGetRecentlyAdded(
  Dio client, {
  required int count,
  int? start,
  TautulliMediaType? mediaType,
  int? sectionId,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_recently_added',
      'count': count,
      if (start != null) 'start': start,
      if (mediaType != null && mediaType != TautulliMediaType.NULL)
        'media_type': mediaType.value,
      if (sectionId != null) 'section_id': sectionId,
    },
  );
  switch (response.data['response']['result']) {
    case 'success':
      return (response.data['response']['data']['recently_added'] as List)
          .map((content) => TautulliRecentlyAdded.fromJson(content))
          .toList();
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
