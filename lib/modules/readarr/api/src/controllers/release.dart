part of readarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to releases within Readarr.
///
/// [ReadarrControllerRelease] internally handles routing the HTTP client to the API calls.
class ReadarrControllerRelease {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  ReadarrControllerRelease(this._client);

  /// Handler for [release](https://github.com/Readarr/Readarr/wiki/Release#get).
  ///
  /// Returns the a list of releases for the episode.
  Future<List<ReadarrRelease>> get({
    required int bookId,
  }) async =>
      _commandGetReleases(_client, bookId: bookId);

  /// Handler for [release](https://github.com/Readarr/Readarr/wiki/Release#get).
  ///
  /// Returns the a list of releases for the season.
  Future<List<ReadarrRelease>> getAuthorPack({
    required int authorId,
  }) async =>
      _commandGetAuthorReleases(_client, authorId: authorId);

  /// Handler for [release](https://github.com/Readarr/Readarr/wiki/Release#post).
  ///
  /// Adds a previously searched release to the download client, if the release is still in Readarr's search cache (30 minute cache).
  /// If the release is not found in the cache Readarr will return a 404.
  Future<ReadarrAddedRelease> add({
    required String guid,
    required int indexerId,
  }) async =>
      _commandAddRelease(_client, guid: guid, indexerId: indexerId);
}
