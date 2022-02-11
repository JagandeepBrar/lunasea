part of readarr_commands;

Future<List<ReadarrBook>> _commandGetCalendar(
  Dio client, {
  DateTime? start,
  DateTime? end,
  bool? unmonitored,
  bool? includeAuthor,
  bool? includeEpisodeFile,
  bool? includeBookImages,
}) async {
  Response response = await client.get('calendar', queryParameters: {
    if (start != null) 'start': DateFormat('y-MM-dd').format(start),
    if (end != null) 'end': DateFormat('y-MM-dd').format(end),
    if (unmonitored != null) 'unmonitored': unmonitored,
    if (includeAuthor != null) 'includeAuthor': includeAuthor,
    if (includeEpisodeFile != null) 'includeEpisodeFile': includeEpisodeFile,
    if (includeBookImages != null) 'includeBookImages': includeBookImages,
  });
  return (response.data as List)
      .map((calendar) => ReadarrBook.fromJson(calendar))
      .toList();
}
