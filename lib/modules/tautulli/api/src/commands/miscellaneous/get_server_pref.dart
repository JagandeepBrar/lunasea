part of tautulli_commands;

Future<dynamic> _commandGetServerPref(
  Dio client, {
  required String preference,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_server_pref',
      'pref': preference,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return response.data['response']['data'];
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
