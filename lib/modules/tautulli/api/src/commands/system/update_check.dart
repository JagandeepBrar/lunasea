part of tautulli_commands;

Future<TautulliUpdateCheck> _commandUpdateCheck(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'update_check',
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return TautulliUpdateCheck.fromJson(response.data['response']['data']);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
