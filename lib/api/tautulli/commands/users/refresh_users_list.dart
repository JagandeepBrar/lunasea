part of tautulli_commands;

Future<void> _commandRefreshUsersList(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'refresh_users_list',
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
