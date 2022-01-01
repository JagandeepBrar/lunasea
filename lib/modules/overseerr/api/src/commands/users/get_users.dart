part of overseerr_commands;

Future<OverseerrUserPage> _commandGetUsers(
  Dio client, {
  int? take,
  int? skip,
  OverseerrUserSortType? sort,
}) async {
  Response response = await client.get(
    'user',
    queryParameters: {
      if (take != null) 'take': take,
      if (skip != null) 'skip': skip,
      if (sort != null) 'sort': sort.value,
    },
  );
  return OverseerrUserPage.fromJson(response.data);
}
