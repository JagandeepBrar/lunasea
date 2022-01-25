part of tautulli_commands;

Future<void> _commandNotifyNewsletter(
  Dio client, {
  required int newsletterId,
  String? subject,
  String? body,
  String? message,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'notify_newsletter',
      'newsletter_id': newsletterId,
      if (subject != null) 'subject': subject,
      if (body != null) 'body': body,
      if (message != null) 'message': message,
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
