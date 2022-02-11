part of readarr_commands;

Future<List<ReadarrRootFolder>> _commandGetRootFolders(Dio client) async {
  Response response = await client.get('rootfolder');
  return (response.data as List)
      .map((folder) => ReadarrRootFolder.fromJson(folder))
      .toList();
}
