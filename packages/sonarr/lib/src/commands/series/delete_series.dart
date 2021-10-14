part of sonarr_commands;

Future<SonarrSeries> _commandDeleteSeries(Dio client, {
    required int seriesId,
    bool deleteFiles = false,
}) async {
    Response response = await client.delete('series/$seriesId', queryParameters: {
        'deleteFiles': deleteFiles,
    });
    return SonarrSeries.fromJson(response.data);
}
