part of sonarr_commands;

Future<SonarrMissing> _commandGetMissing(Dio client, {
    SonarrSortDirection? sortDir,
    SonarrWantedMissingSortKey? sortKey,
    int? page,
    int? pageSize,
}) async {
    Response response = await client.get('wanted/missing', queryParameters: {
        if(sortDir != null) 'sortDir': sortDir.value,
        if(sortKey != null) 'sortKey': sortKey.value,
        if(page != null) 'page': page,
        if(pageSize != null) 'pageSize': pageSize,
    });
    return SonarrMissing.fromJson(response.data);
}
