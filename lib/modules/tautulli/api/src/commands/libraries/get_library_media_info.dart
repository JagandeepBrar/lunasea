part of tautulli_commands;

Future<TautulliLibraryMediaInfo> _commandGetLibraryMediaInfo(
  Dio client, {
  int? sectionId,
  int? ratingKey,
  TautulliSectionType? sectionType,
  TautulliOrderDirection? orderDirection,
  TautulliLibraryMediaInfoOrderColumn? orderColumn,
  int? start,
  int? length,
  String? search,
  bool? refresh,
}) async {
  if (sectionId != null)
    assert(
        ratingKey == null, 'sectionId and ratingKey both cannot be defined.');
  if (sectionId == null)
    assert(ratingKey != null, 'sectionId and ratingKey cannot both be null.');
  if (ratingKey == null)
    assert(sectionId != null, 'sectionId and ratingKey cannot both be null.');
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_library_media_info',
      if (sectionId != null) 'section_id': sectionId,
      if (ratingKey != null) 'rating_key': ratingKey,
      if (sectionType != null && sectionType != TautulliSectionType.NULL)
        'section_type': sectionType.value,
      if (orderDirection != null &&
          orderDirection != TautulliOrderDirection.NULL)
        'order_dir': orderDirection.value,
      if (orderColumn != null &&
          orderColumn != TautulliLibraryMediaInfoOrderColumn.NULL)
        'order_column': orderColumn.value,
      if (start != null) 'start': start,
      if (length != null) 'length': length,
      if (search != null) 'search': search,
      if (refresh != null) 'refresh': refresh,
    },
  );
  switch (response.data['response']['result']) {
    case 'success':
      return TautulliLibraryMediaInfo.fromJson(
          response.data['response']['data']);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
