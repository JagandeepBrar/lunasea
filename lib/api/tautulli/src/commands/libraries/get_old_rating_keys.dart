part of tautulli_commands;

Future<Map<String, dynamic>?> _commandGetOldRatingKeys(
  Dio client, {
  required int ratingKey,
  required TautulliMediaType mediaType,
}) async {
  assert(mediaType != TautulliMediaType.NULL, 'mediaType cannot be null.');
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_old_rating_keys',
      'rating_key': ratingKey,
      'media_type': mediaType.value,
    },
  );
  switch (response.data['response']['result']) {
    case 'success':
      return response.data['response']['data'];
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
