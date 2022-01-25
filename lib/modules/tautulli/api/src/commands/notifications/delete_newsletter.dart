part of tautulli_commands;

Future<void> _commandDeleteNewsletter(
  Dio client, {
  required int newsletterId,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'delete_newsletter',
      'newsletter_id': newsletterId,
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
