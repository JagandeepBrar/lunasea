part of tautulli_commands;

Future<TautulliHistory> _commandGetHistory(
  Dio client, {
  bool? grouping,
  String? user,
  int? userId,
  int? ratingKey,
  int? parentRatingKey,
  int? grandparentRatingKey,
  String? startDate,
  int? sectionId,
  TautulliMediaType? mediaType,
  TautulliTranscodeDecision? transcodeDecision,
  String? guid,
  TautulliHistoryOrderColumn? orderColumn,
  TautulliOrderDirection? orderDirection,
  int? start,
  int? length,
  String? search,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_history',
      if (grouping != null) 'grouping': grouping ? 1 : 0,
      if (user != null) 'user': user,
      if (userId != null) 'user_id': userId,
      if (ratingKey != null) 'rating_key': ratingKey,
      if (parentRatingKey != null) 'parent_rating_key': parentRatingKey,
      if (grandparentRatingKey != null)
        'grandparent_rating_key': grandparentRatingKey,
      if (startDate != null) 'start_date': startDate,
      if (mediaType != null && mediaType != TautulliMediaType.NULL)
        'media_type': mediaType.value,
      if (transcodeDecision != null &&
          transcodeDecision != TautulliTranscodeDecision.NULL)
        'transcode_decision': transcodeDecision.value,
      if (guid != null) 'guid': guid,
      if (orderColumn != null && orderColumn != TautulliHistoryOrderColumn.NULL)
        'order_column': orderColumn.value,
      if (orderDirection != null &&
          orderDirection != TautulliOrderDirection.NULL)
        'order_direction': orderDirection.value,
      if (start != null) 'start': start,
      if (length != null) 'length': length,
      if (search != null) 'search': search,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return TautulliHistory.fromJson(response.data['response']['data']);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
