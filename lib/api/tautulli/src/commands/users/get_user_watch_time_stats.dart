part of tautulli_commands;

Future<List<TautulliUserWatchTimeStats>> _commandGetUserWatchTimeStats(
  Dio client, {
  required int userId,
  bool? grouping,
  List<int>? queryDays,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_user_watch_time_stats',
      'user_id': userId,
      if (grouping != null) 'grouping': grouping ? 1 : 0,
      if (queryDays != null && queryDays.isNotEmpty)
        'query_days': queryDays.join(","),
    },
  );
  switch (response.data['response']['result']) {
    case 'success':
      return (response.data['response']['data'] as List)
          .map((library) => TautulliUserWatchTimeStats.fromJson(library))
          .toList();
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
