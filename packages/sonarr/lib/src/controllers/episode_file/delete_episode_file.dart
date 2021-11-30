part of sonarr_commands;

Future<void> _commandDeleteEpisodeFile(Dio client, {
    required int episodeFileId,
}) async {
    await client.delete('episodefile/${episodeFileId}');
}
