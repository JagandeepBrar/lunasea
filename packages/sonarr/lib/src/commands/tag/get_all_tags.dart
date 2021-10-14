part of sonarr_commands;

Future<List<SonarrTag>> _commandGetAllTags(Dio client) async {
    Response response = await client.get('tag');
    return (response.data as List).map((tag) => SonarrTag.fromJson(tag)).toList();
}
