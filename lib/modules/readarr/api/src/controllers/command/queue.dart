part of readarr_commands;

Future<List<ReadarrCommand>> _commandCommandQueue(Dio client) async {
  Response response = await client.get('command');
  return (response.data as List)
      .map((command) => ReadarrCommand.fromJson(command))
      .toList();
}
