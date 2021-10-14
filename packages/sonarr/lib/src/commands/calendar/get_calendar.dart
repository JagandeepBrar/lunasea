part of sonarr_commands;

Future<List<SonarrCalendar>> _commandGetCalendar(Dio client, {
    DateTime? start,
    DateTime? end,
}) async {
    Response response = await client.get('calendar', queryParameters: {
        if(start != null) 'start': DateFormat('y-MM-dd').format(start),
        if(end != null) 'end': DateFormat('y-MM-dd').format(end),
    });
    return (response.data as List).map((calendar) => SonarrCalendar.fromJson(calendar)).toList();
}
