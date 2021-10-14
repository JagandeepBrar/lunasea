part of sonarr_commands;

Future<SonarrHistory> _commandGetHistory(Dio client, {
    required SonarrHistorySortKey sortKey,
    int? page,
    int? pageSize,
    SonarrSortDirection? sortDirection,
    int? episodeId,
}) async {
    Response response = await client.get('history', queryParameters: {
        'sortKey': sortKey.value,
        if(page != null) 'page': page,
        if(pageSize != null) 'pageSize': pageSize,
        if(sortDirection != null) 'sortDir': sortDirection.value,
        if(episodeId != null) 'episodeId': episodeId,
    });
    return SonarrHistory.fromJson(response.data);
}
