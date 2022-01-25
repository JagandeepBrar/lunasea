part of tautulli_commands;

Future<void> _commandDeleteAllLibraryHistory(
  Dio client, {
  required int sectionId,
  String? serverId,
  List<int>? rowIds,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'delete_all_library_history',
      'section_id': sectionId,
      if (serverId != null) 'server_id': serverId,
      if (rowIds != null && rowIds.isNotEmpty) 'row_ids': rowIds.join(","),
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return;
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
