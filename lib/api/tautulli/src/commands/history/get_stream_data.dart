part of tautulli_commands;

Future<TautulliStreamData> _commandGetStreamData(
  Dio client, {
  int? rowId,
  int? sessionKey,
}) async {
  if (rowId != null)
    assert(sessionKey == null, 'rowId and sessionKey cannot both be defined.');
  if (rowId == null)
    assert(sessionKey != null, 'rowId and sessionKey cannot both be null.');
  if (sessionKey == null)
    assert(rowId != null, 'rowId and sessionKey cannot both be null.');
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_stream_data',
      if (rowId != null) 'row_id': rowId,
      if (sessionKey != null) 'session_key': sessionKey,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return TautulliStreamData.fromJson(response.data['response']['data']);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
