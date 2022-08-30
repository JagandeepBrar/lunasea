part of tautulli_commands;

Future<Map<String, dynamic>?> _commandGetSettings(
  Dio client, {
  String? key,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_settings',
      if (key != null) 'key': key,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return (response.data['response']['data'] as Map<String, dynamic>?);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
