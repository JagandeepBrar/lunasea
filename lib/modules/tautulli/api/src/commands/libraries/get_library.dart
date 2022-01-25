part of tautulli_commands;

Future<TautulliSingleLibrary> _commandGetLibrary(
  Dio client, {
  required int sectionId,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_library',
      'section_id': sectionId,
    },
  );
  switch (response.data['response']['result']) {
    case 'success':
      return TautulliSingleLibrary.fromJson(response.data['response']['data']);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
