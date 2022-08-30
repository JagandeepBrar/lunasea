part of tautulli_commands;

Future<void> _commandUpdateMetadataDetails(
  Dio client, {
  required int oldRatingKey,
  required int newRatingKey,
  required TautulliMediaType mediaType,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'update_metadata_details',
      'old_rating_key': oldRatingKey,
      'new_rating_key': newRatingKey,
      'media_type': mediaType.value,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return;
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
