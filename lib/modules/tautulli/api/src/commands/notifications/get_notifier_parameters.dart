part of tautulli_commands;

Future<List<TautulliNotifierParameter>> _commandGetNotifierParameters(
    Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_notifier_parameters',
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return (response.data['response']['data'] as List)
          .map((parameter) => TautulliNotifierParameter.fromJson(parameter))
          .toList();
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
