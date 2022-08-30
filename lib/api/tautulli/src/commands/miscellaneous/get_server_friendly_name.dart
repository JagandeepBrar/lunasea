part of tautulli_commands;

Future<String?> _commandGetServerFriendlyName(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_server_friendly_name',
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
