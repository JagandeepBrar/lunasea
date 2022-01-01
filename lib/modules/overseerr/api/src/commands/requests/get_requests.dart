part of overseerr_commands;

Future<OverseerrRequestPage> _commandGetRequests(
  Dio client, {
  int? take,
  int? skip,
  OverseerrRequestFilterType? filter,
  OverseerrRequestSortType? sort,
  OverseerrUser? requestedBy,
}) async {
  Response response = await client.get(
    'request',
    queryParameters: {
      if (take != null) 'take': take,
      if (skip != null) 'skip': skip,
      if (sort != null) 'sort': sort.value,
      if (filter != null) 'filter': filter.value,
      if (requestedBy != null) 'requestedBy': requestedBy.id,
    },
  );
  return OverseerrRequestPage.fromJson(response.data);
}
