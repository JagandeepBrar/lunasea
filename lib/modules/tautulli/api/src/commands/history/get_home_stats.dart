part of tautulli_commands;

Future<List<TautulliHomeStats>> _commandGetHomeStats(
  Dio client, {
  bool? grouping,
  int? timeRange,
  TautulliStatsType? statsType,
  int? statsCount,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_home_stats',
      if (grouping != null) 'grouping': grouping ? 1 : 0,
      if (timeRange != null && timeRange >= 1) 'time_range': timeRange,
      if (statsType != null) 'stats_type': statsType.value,
      if (statsCount != null) 'stats_count': statsCount,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return (response.data['response']['data'] as List)
          .map((stats) => TautulliHomeStats.fromJson(stats))
          .toList();
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
