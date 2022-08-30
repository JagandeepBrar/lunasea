part of tautulli_commands;

Future<Uint8List?> _commandDownloadConfig(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'download_config',
    },
    options: Options(
      responseType: ResponseType.bytes,
    ),
  );
  return (response.data as Uint8List?);
}
