part of tautulli_commands;

Future<List<TautulliLog>> _commandGetLogs(
  Dio client, {
  String? search,
  TautulliLogsOrderColumn? orderColumn,
  TautulliOrderDirection? orderDirection,
  String? regex,
  int? start,
  int? end,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_logs',
      if (search != null) 'search': search,
      if (orderColumn != null && orderColumn != TautulliLogsOrderColumn.NULL)
        'sort': orderColumn.value,
      if (orderDirection != null &&
          orderDirection != TautulliOrderDirection.NULL)
        'order': orderDirection.value,
      if (regex != null) 'regex': regex,
      if (start != null) 'start': start,
      if (end != null) 'end': end,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return (response.data['response']['data'] as List)
          .map((log) => TautulliLog.fromJson(log))
          .toList();
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
