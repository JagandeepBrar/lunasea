part of tautulli_commands;

Future<void> _commandDeleteHostedImages(
  Dio client, {
  int? ratingKey,
  TautulliImageHostService? service,
  bool? deleteAll,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'delete_hosted_images',
      if (ratingKey != null) 'rating_key': ratingKey,
      if (service != null) 'service': service.value,
      if (deleteAll != null) 'delete_all': deleteAll,
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
