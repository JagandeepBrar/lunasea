part of tautulli_commands;

Future<void> _commandDeleteHistory(
  Dio client, {
  required List<int> rowIds,
}) async {
  assert(rowIds.isNotEmpty, 'rowIds cannot be empty.');
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'delete_history',
      'row_ids': rowIds.join(","),
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
