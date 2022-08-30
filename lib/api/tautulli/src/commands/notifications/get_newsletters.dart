part of tautulli_commands;

Future<List<TautulliNewsletter>> _commandGetNewsletters(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_newsletters',
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return (response.data['response']['data'] as List)
          .map((notifier) => TautulliNewsletter.fromJson(notifier))
          .toList();
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
