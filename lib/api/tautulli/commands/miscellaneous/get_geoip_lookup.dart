part of tautulli_commands;

Future<TautulliGeolocationInfo> _commandGetGeoIPLookup(
  Dio client, {
  required String ipAddress,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_geoip_lookup',
      'ip_address': ipAddress,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return TautulliGeolocationInfo.fromJson(
          response.data['response']['data']);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
