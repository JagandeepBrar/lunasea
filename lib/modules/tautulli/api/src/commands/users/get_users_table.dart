part of tautulli_commands;

Future<TautulliUsersTable> _commandGetUsersTable(
  Dio client, {
  bool? grouping,
  TautulliUsersOrderColumn? orderColumn,
  TautulliOrderDirection? orderDirection,
  int? start,
  int? length,
  String? search,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_users_table',
      if (grouping != null) 'grouping': grouping ? 1 : 0,
      if (orderColumn != null && orderColumn != TautulliUsersOrderColumn.NULL)
        'order_column': orderColumn.value,
      if (orderDirection != null &&
          orderDirection != TautulliOrderDirection.NULL)
        'order_dir': orderDirection.value,
      if (start != null) 'start': start,
      if (length != null) 'length': length,
      if (search != null) 'search': search,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return TautulliUsersTable.fromJson(response.data['response']['data']);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
