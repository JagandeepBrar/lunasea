part of readarr_commands;

Future<ReadarrAddedRelease> _commandAddRelease(
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
  return ReadarrAddedRelease.fromJson(response.data);
}
