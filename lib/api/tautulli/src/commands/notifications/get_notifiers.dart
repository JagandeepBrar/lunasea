part of tautulli_commands;

Future<List<TautulliNotifier>> _commandGetNotifiers(
  Dio client, {
  String? notifyAction,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_notifiers',
      if (notifyAction != null) 'notify_action': notifyAction,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return (response.data['response']['data'] as List)
          .map((notifier) => TautulliNotifier.fromJson(notifier))
          .toList();
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
