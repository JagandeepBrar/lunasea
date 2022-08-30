part of tautulli_commands;

Future<Uint8List?> _commandDocsMd(Dio client) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'docs_md',
    },
    options: Options(
      responseType: ResponseType.bytes,
    ),
  );
  return (response.data as Uint8List?);
}
