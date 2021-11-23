part of sonarr_commands;

Future<void> _commandDeleteQueue(Dio client, {
    required int id,
    bool? blacklist,
}) async {
    await client.delete('queue/$id', queryParameters: {
        if(blacklist != null) 'blacklist': blacklist,
    });
}
