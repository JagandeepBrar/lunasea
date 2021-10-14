part of sonarr_commands;

Future<SonarrTag> _commandUpdateTag(Dio client, {
    required SonarrTag tag,
}) async {
    Response response = await client.put('tag', data: tag.toJson());
    return SonarrTag.fromJson(response.data);
}
