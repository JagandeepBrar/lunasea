part of tautulli_commands;

Future<void> _commandDeleteNotifier(
  Dio client, {
  required int notifierId,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'delete_notifier',
      'notifier_id': notifierId,
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
