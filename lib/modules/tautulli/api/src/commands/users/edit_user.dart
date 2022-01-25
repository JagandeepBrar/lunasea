part of tautulli_commands;

Future<void> _commandEditUser(
  Dio client, {
  required int userId,
  String? friendlyName,
  String? customThumb,
  bool? keepHistory,
  bool? allowGuest,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'edit_user',
      'user_id': userId,
      if (friendlyName != null) 'friendly_name': friendlyName,
      if (customThumb != null) 'custom_thumb': customThumb,
      if (keepHistory != null) 'keep_history': keepHistory ? 1 : 0,
      if (allowGuest != null) 'allow_guest': allowGuest ? 1 : 0,
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
