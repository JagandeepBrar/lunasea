part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to episodes within Sonarr.
/// 
/// [SonarrCommandHandler_Episode] internally handles routing the HTTP client to the API calls.
class SonarrCommandHandler_Episode {
    final Dio _client;

    /// Create a series command handler using an initialized [Dio] client.
    SonarrCommandHandler_Episode(this._client);

    /// Handler for [episode?seriesid={id}](https://github.com/Sonarr/Sonarr/wiki/Episode#get).
    /// 
    /// Returns all episodes for the given series.
    /// 
    /// Required Parameters:
    /// - `seriesId`: Series ID for which to fetch episodes for
    Future<List<SonarrEpisode>> getSeriesEpisodes({
        required int seriesId,
    }) async => _commandGetSeriesEpisodes(_client, seriesId: seriesId);

    /// Handler for [episode/{id}](https://github.com/Sonarr/Sonarr/wiki/Episode#getid).
    /// 
    /// Returns the episode with the matching ID.
    /// 
    /// Required Parameters:
    /// - `episodeId`: Episode ID for the episode to fetch
    Future<SonarrEpisode> getEpisode({
        required int episodeId,
    }) async => _commandGetEpisode(_client, episodeId: episodeId);

    /// Handler for [episode](https://github.com/Sonarr/Sonarr/wiki/Episode#put).
    /// 
    /// Update the given episode, currently only monitored is changed, all other modifications are ignored.
    /// 
    /// Required Parameters:
    /// - `episode`: [SonarrEpisode] object containing the updated episode
    Future<SonarrEpisode> updateEpisode({
        required SonarrEpisode episode,
    }) async => _commandUpdateEpisode(_client, episode: episode);
}
