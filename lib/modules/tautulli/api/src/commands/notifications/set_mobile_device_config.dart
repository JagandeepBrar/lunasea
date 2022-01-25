part of tautulli_commands;

Future<void> _commandSetMobileDeviceConfig(
  Dio client, {
  required int mobileDeviceId,
  String? friendlyName,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'set_mobile_device_config',
      'mobile_device_id': mobileDeviceId,
      if (friendlyName != null) 'friendly_name': friendlyName,
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
