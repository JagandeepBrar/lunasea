part of tautulli_commands;

Future<List<TautulliPlexLog>> _commandGetPlexLog(
  Dio client, {
  int? window,
  TautulliPlexLogType? logType,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_plex_log',
      if (window != null) 'window': window,
      if (logType != null && logType != TautulliPlexLogType.NULL)
        'log_type': logType.value,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return (response.data['response']['data']['data'] as List)
          .map((log) => TautulliPlexLog.fromArray(log))
          .toList();
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
