part of tautulli_commands;

Future<TautulliGraphData> _commandGetStreamTypeByTopTenUsers(
  Dio client, {
  int? timeRange,
  int? userId,
  bool? grouping,
  TautulliGraphYAxis? yAxis,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_stream_type_by_top_10_users',
      if (timeRange != null && timeRange >= 1) 'time_range': timeRange,
      if (userId != null) 'user_id': userId,
      if (grouping != null) 'grouping': grouping ? 1 : 0,
      if (yAxis != null && yAxis != TautulliGraphYAxis.NULL)
        'y_axis': yAxis.value,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return TautulliGraphData.fromJson(response.data['response']['data']);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
