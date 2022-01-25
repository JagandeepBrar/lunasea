part of tautulli_commands;

Future<void> _commandSetNotifierConfig(
  Dio client, {
  required int agentId,
  required int notifierId,
  required Map<String, dynamic> notifierOptions,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'set_notifier_config',
      'agent_id': agentId,
      'notifier_id': notifierId,
      ...notifierOptions,
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
