part of sonarr_commands;

Future<List<SonarrSeriesLookup>> _commandGetSeriesLookup(Dio client, {
    required String term,
}) async {
    Response response = await client.get('series/lookup', queryParameters: {
        'term': term,
    });
    return (response.data as List).map((series) => SonarrSeriesLookup.fromJson(series)).toList();
}
