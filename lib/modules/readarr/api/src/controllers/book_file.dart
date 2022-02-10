part of readarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to episode files within Readarr.
///
/// [ReadarrControllerBookFile] internally handles routing the HTTP client to the API calls.
class ReadarrControllerBookFile {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  ReadarrControllerBookFile(this._client);

  /// Handler for [episodefile/{id}](https://github.com/Readarr/Readarr/wiki/EpisodeFile#delete).
  ///
  /// Delete the given episode file.
  ///
  /// Required Parameters:
  /// - `episodeFileId`: Episode ID for the episode to fetch
  Future<void> delete({
    required int bookFileId,
  }) async =>
      _commandDeleteBookFile(_client, bookFileId: bookFileId);

  /// Handler for [episodefile/{id}](https://github.com/Readarr/Readarr/wiki/EpisodeFile#get).
  ///
  /// Returns the episode file with the matching episode ID.
  ///
  /// Required Parameters:
  /// - `bookId`: Episode ID for the episode to fetch
  Future<List<ReadarrBookFile>> get({
    required int bookId,
  }) async =>
      _commandGetBookFile(_client, bookId: bookId);

  /// Handler for [episodefile?seriesid={id}](https://github.com/Readarr/Readarr/wiki/EpisodeFile#getid).
  ///
  /// Returns all episode files for the given series.
  ///
  /// Required Parameters:
  /// - `authorId`: Series ID for which to fetch episodes for
  Future<List<ReadarrBookFile>> getAuthor({
    required int authorId,
  }) async =>
      _commandGetAuthorBookFiles(_client, authorId: authorId);
}
