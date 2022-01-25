part of tautulli_commands;

Future<String?> _commandGetPMSToken(
  Dio client, {
  required String username,
  required String password,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_pms_token',
      'username': username,
      'password': password,
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
