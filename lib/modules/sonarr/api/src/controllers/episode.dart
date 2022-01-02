part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to episodes within Sonarr.
///
/// [SonarrControllerEpisode] internally handles routing the HTTP client to the API calls.
class SonarrControllerEpisode {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  SonarrControllerEpisode(this._client);

  /// Handler for [episode](https://github.com/Sonarr/Sonarr/wiki/Episode#get).
  ///
  /// Returns all episodes for the given series or with the given episode IDs.
  Future<List<SonarrEpisode>> getMulti({
    int? seriesId,
    int? seasonNumber,
    List<int>? episodeIds,
    int? episodeFileId,
    bool? includeImages,
  }) async =>
      _commandGetEpisodes(
        _client,
        seriesId: seriesId,
        seasonNumber: seasonNumber,
        episodeIds: episodeIds,
        episodeFileId: episodeFileId,
        includeImages: includeImages,
      );

  /// Handler for [episode/{id}](https://github.com/Sonarr/Sonarr/wiki/Episode#getid).
  ///
  /// Returns the episode with the matching ID.
  Future<SonarrEpisode> get({
    required int episodeId,
  }) async =>
      _commandGetEpisode(
        _client,
        episodeId: episodeId,
      );

  /// Handler for [episode](https://github.com/Sonarr/Sonarr/wiki/Episode#put).
  ///
  /// Update the given episode, currently only monitored is changed, all other modifications are ignored.
  Future<SonarrEpisode> update({
    required SonarrEpisode episode,
  }) async =>
      _commandUpdateEpisode(
        _client,
        episode: episode,
      );

  /// Handler for `episode/monitor`.
  ///
  /// Sets the monitored state for the given episode IDs.
  Future<List<SonarrEpisode>> setMonitored({
    required List<int> episodeIds,
    required bool monitored,
  }) async =>
      _commandEpisodeSetMonitored(
        _client,
        episodeIds: episodeIds,
        monitored: monitored,
      );
}
