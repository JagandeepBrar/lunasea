part of tautulli_commands;

Future<Uint8List?> _commandDownloadLog(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'download_log',
    },
    options: Options(
      responseType: ResponseType.bytes,
    ),
  );
  return (response.data as Uint8List?);
}
