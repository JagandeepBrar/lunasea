part of sonarr_commands;

Future<List<SonarrSeries>> _commandGetAllSeries(Dio client) async {
  Response response = await client.get('series');
  return (response.data as List)
      .map((series) => SonarrSeries.fromJson(series))
      .toList();
}
