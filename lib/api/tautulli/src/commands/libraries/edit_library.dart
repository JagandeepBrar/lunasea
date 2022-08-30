part of tautulli_commands;

Future<void> _commandEditLibrary(
  Dio client, {
  required int sectionId,
  String? customThumb,
  String? customArt,
  bool? keepHistory,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'edit_library',
      'section_id': sectionId,
      if (customThumb != null) 'custom_thumb': customThumb,
      if (customArt != null) 'custom_art': customArt,
      if (keepHistory != null) 'keep_history': keepHistory ? 1 : 0,
    },
  );
  switch (response.data['response']['result']) {
    case 'success':
      return;
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
