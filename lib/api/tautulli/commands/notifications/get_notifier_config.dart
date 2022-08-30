part of tautulli_commands;

Future<TautulliNotifierConfig> _commandGetNotifierConfig(
  Dio client, {
  required int notifierId,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_notifier_config',
      'notifier_id': notifierId,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return TautulliNotifierConfig.fromJson(response.data['response']['data']);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
