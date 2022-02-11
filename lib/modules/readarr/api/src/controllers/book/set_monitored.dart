part of readarr_commands;

Future<List<ReadarrBook>> _commandBookSetMonitored(
  Dio client, {
  required List<int> bookIds,
  required bool monitored,
}) async {
  Response response = await client.put('book/monitor', data: {
    'bookIds': bookIds,
    'monitored': monitored,
  });
  return (response.data as List)
      .map((episode) => ReadarrBook.fromJson(episode))
      .toList();
}
