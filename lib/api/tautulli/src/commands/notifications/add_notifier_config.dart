part of tautulli_commands;

Future<String?> _commandAddNotifierConfig(
  Dio client, {
  required int agentId,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'add_notifier_config',
      'agent_id': agentId,
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
