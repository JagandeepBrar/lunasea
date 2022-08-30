part of tautulli_commands;

Future<TautulliDateFormat> _commandGetDateFormats(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_date_formats',
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return TautulliDateFormat.fromJson(response.data['response']['data']);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
