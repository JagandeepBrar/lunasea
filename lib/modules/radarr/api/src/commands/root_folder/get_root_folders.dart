part of radarr_commands;

Future<List<RadarrRootFolder>> _commandGetRootFolders(Dio client) async {
  Response response = await client.get('rootfolder');
  return (response.data as List)
      .map((folder) => RadarrRootFolder.fromJson(folder))
      .toList();
}
