part of tautulli_commands;

Future<void> _commandDeleteMobileDevice(
  Dio client, {
  required int mobileDeviceId,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'delete_mobile_device',
      'mobile_device_id': mobileDeviceId,
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
