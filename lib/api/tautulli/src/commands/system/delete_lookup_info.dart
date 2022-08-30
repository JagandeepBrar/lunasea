part of tautulli_commands;

Future<void> _commandDeleteLookupInfo(
  Dio client, {
  int? ratingKey,
  TautulliAPILookupService? service,
  bool? deleteAll,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'delete_lookup_info',
      if (ratingKey != null) 'rating_key': ratingKey,
      if (service != null) 'service': service,
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
