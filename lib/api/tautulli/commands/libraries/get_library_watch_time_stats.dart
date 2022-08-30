part of tautulli_commands;

Future<List<TautulliLibraryWatchTimeStats>> _commandGetLibraryWatchTimeStats(
  Dio client, {
  required int sectionId,
  bool? grouping,
  List<int>? queryDays,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_library_watch_time_stats',
      'section_id': sectionId,
      if (grouping != null) 'grouping': grouping ? 1 : 0,
      if (queryDays != null && queryDays.isNotEmpty)
        'query_days': queryDays.join(","),
    },
  );
  switch (response.data['response']['result']) {
    case 'success':
      return (response.data['response']['data'] as List)
          .map((library) => TautulliLibraryWatchTimeStats.fromJson(library))
          .toList();
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
