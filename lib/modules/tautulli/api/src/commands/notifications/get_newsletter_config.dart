part of tautulli_commands;

Future<TautulliNewsletterConfig> _commandGetNewsletterConfig(
  Dio client, {
  required int newsletterId,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_newsletter_config',
      'newsletter_id': newsletterId,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return TautulliNewsletterConfig.fromJson(
          response.data['response']['data']);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
