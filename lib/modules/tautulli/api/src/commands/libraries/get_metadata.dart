part of tautulli_commands;

Future<TautulliMetadata> _commandGetMetadata(
  Dio client, {
  required int ratingKey,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_metadata',
      'rating_key': ratingKey,
    },
  );
  switch (response.data['response']['result']) {
    case 'success':
      return TautulliMetadata.fromJson(response.data['response']['data']);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
