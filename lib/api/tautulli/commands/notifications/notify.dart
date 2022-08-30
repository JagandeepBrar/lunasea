part of tautulli_commands;

Future<void> _commandNotify(
  Dio client, {
  required int notifierId,
  required String subject,
  required String body,
  String? headers,
  String? scriptArgs,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'notify',
      'notifier_id': notifierId,
      'subject': subject,
      'body': body,
      if (headers != null) 'headers': headers,
      if (scriptArgs != null) 'script_args': scriptArgs,
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
