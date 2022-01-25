part of tautulli_commands;

Future<List<TautulliLibraryName>> _commandGetLibraryNames(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_library_names',
    },
  );
  switch (response.data['response']['result']) {
    case 'success':
      return (response.data['response']['data'] as List)
          .map((library) => TautulliLibraryName.fromJson(library))
          .toList();
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
