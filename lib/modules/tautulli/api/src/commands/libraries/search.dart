part of tautulli_commands;

Future<TautulliSearch> _commandSearch(
  Dio client, {
  required String query,
  int? limit,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'search',
      'query': query,
      if (limit != null) 'limit': limit,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return TautulliSearch.fromJson(response.data['response']['data']);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
