part of tautulli_commands;

Future<TautulliLibrariesTable> _commandGetLibrariesTable(
  Dio client, {
  bool? grouping,
  TautulliLibrariesOrderColumn? orderColumn,
  TautulliOrderDirection? orderDirection,
  int? start,
  int? length,
  String? search,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_libraries_table',
      if (grouping != null) 'grouping': grouping ? 1 : 0,
      if (orderColumn != null &&
          orderColumn != TautulliLibrariesOrderColumn.NULL)
        'order_column': orderColumn.value,
      if (orderDirection != null &&
          orderDirection != TautulliOrderDirection.NULL)
        'order_dir': orderDirection.value,
      if (start != null) 'start': start,
      if (length != null) 'length': length,
      if (search != null) 'search': search,
    },
  );
  switch (response.data['response']['result']) {
    case 'success':
      return TautulliLibrariesTable.fromJson(response.data['response']['data']);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
