part of tautulli_commands;

Future<List<TautulliLibrary>> _commandGetLibraries(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_libraries',
    },
  );
  switch (response.data['response']['result']) {
    case 'success':
      return (response.data['response']['data'] as List)
          .map((library) => TautulliLibrary.fromJson(library))
          .toList();
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
