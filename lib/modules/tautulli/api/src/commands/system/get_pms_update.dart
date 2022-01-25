part of tautulli_commands;

Future<TautulliPMSUpdate> _commandGetPMSUpdate(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_pms_update',
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return TautulliPMSUpdate.fromJson(response.data['response']['data']);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
