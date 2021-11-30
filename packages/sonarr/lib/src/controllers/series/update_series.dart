part of sonarr_commands;

Future<SonarrSeries> _commandUpdateSeries(Dio client, {
    required SonarrSeries series,
}) async {
    Response response = await client.put('series', data: series.toJson());
    return SonarrSeries.fromJson(response.data);
}
