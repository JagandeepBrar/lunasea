part of tautulli_commands;

Future<List<TautulliUserPlayerStats>> _commandGetUserPlayerStats(
  Dio client, {
  required int userId,
  bool? grouping,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_user_player_stats',
      'user_id': userId,
      if (grouping != null) 'grouping': grouping ? 1 : 0,
    },
  );
  switch (response.data['response']['result']) {
    case 'success':
      return (response.data['response']['data'] as List)
          .map((library) => TautulliUserPlayerStats.fromJson(library))
          .toList();
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
