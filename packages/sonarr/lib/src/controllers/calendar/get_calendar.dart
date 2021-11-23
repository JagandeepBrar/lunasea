part of sonarr_commands;

Future<List<SonarrCalendar>> _commandGetCalendar(
  Dio client, {
  DateTime? start,
  DateTime? end,
  bool? unmonitored,
  bool? includeSeries,
  bool? includeEpisodeFile,
  bool? includeEpisodeImages,
}) async {
  Response response = await client.get('calendar', queryParameters: {
    if (start != null) 'start': DateFormat('y-MM-dd').format(start),
    if (end != null) 'end': DateFormat('y-MM-dd').format(end),
    if (unmonitored != null) 'unmonitored': unmonitored,
    if (includeSeries != null) 'includeSeries': includeSeries,
    if (includeEpisodeFile != null) 'includeEpisodeFile': includeEpisodeFile,
    if (includeEpisodeImages != null)
      'includeEpisodeImages': includeEpisodeImages,
  });
  return (response.data as List)
      .map((calendar) => SonarrCalendar.fromJson(calendar))
      .toList();
}
