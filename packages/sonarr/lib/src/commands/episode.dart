part of sonarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to episodes within Sonarr.
///
/// [SonarrCommandHandler_Episode] internally handles routing the HTTP client to the API calls.
class SonarrCommandHandler_Episode {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  SonarrCommandHandler_Episode(this._client);

  /// Handler for [episode](https://github.com/Sonarr/Sonarr/wiki/Episode#get).
  ///
  /// Returns all episodes for the given series or with the given episode IDs.
  ///
  /// Required One of Parameters:
  /// - `seriesId`: Series ID for which to fetch episodes for
  /// - `episodeIds`: Episode IDs to fetch
  /// - `episodeFileId`: Episode file ID to fetch
  ///
  /// Optional Parameters:
  /// - `includeImages`: Include image paths
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
  ///
  /// Required Parameters:
  /// - `episodeId`: Episode ID for the episode to fetch
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
  ///
  /// Required Parameters:
  /// - `episode`: [SonarrEpisode] object containing the updated episode
  Future<SonarrEpisode> updateEpisode({
    required SonarrEpisode episode,
  }) async =>
      _commandUpdateEpisode(_client, episode: episode);
}
