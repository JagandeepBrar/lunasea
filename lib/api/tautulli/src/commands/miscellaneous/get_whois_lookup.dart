part of tautulli_commands;

Future<TautulliWHOISInfo> _commandGetWHOISLookup(
  Dio client, {
  required String ipAddress,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_whois_lookup',
      'ip_address': ipAddress,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return TautulliWHOISInfo.fromJson(response.data['response']['data']);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
