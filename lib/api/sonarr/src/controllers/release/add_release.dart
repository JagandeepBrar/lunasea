part of sonarr_commands;

Future<SonarrAddedRelease> _commandAddRelease(
  Dio client, {
  required String guid,
  required int indexerId,
}) async {
  Response response = await client.post(
    'release',
    data: {
      'guid': guid,
      'indexerId': indexerId,
    },
  );
  return SonarrAddedRelease.fromJson(response.data);
}
