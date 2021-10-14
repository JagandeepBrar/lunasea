part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to queue within Sonarr.
/// 
/// [SonarrCommandHandler_Queue] internally handles routing the HTTP client to the API calls.
class SonarrCommandHandler_Queue {
    final Dio _client;

    /// Create a series command handler using an initialized [Dio] client.
    SonarrCommandHandler_Queue(this._client);

    /// Handler for [queue](https://github.com/Sonarr/Sonarr/wiki/Queue#get).
    /// 
    /// Gets currently downloading (queue) information.
    Future<List<SonarrQueueRecord>> getQueue() async => _commandGetQueue(_client);

    /// Handler for [queue](https://github.com/Sonarr/Sonarr/wiki/Queue#delete).
    /// 
    /// Deletes an item from the queue and download client..
    Future<void> deleteQueue({
        required int id,
        bool? blacklist,
    }) async => _commandDeleteQueue(_client, id: id, blacklist: blacklist);
}
