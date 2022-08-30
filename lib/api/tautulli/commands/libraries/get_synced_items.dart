part of tautulli_commands;

Future<List<TautulliSyncedItem>> _commandGetSyncedItems(
  Dio client, {
  String? machineId,
  int? userId,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_synced_items',
      if (machineId != null) 'machine_id': machineId,
      if (userId != null) 'user_id': userId,
    },
  );
  switch (response.data['response']['result']) {
    case 'success':
      return (response.data['response']['data'] as List)
          .map((item) => TautulliSyncedItem.fromJson(item))
          .toList();
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
