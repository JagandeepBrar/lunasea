part of readarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to series within Readarr.
///
/// [ReadarrControllerBook] internally handles routing the HTTP client to the API calls.
class ReadarrControllerBook {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  ReadarrControllerBook(this._client);

/*
  /// Handler for [series](https://github.com/Readarr/Readarr/wiki/Series#post).
  ///
  /// Adds a new series to your collection.
  Future<ReadarrAuthor> create({
    required ReadarrAuthor author,
    required ReadarrQualityProfile qualityProfile,
    required ReadarrMetadataProfile metadataProfile,
    required ReadarrRootFolder rootFolder,
    required ReadarrAuthorMonitorType monitorType,
    List<ReadarrTag> tags = const [],
    bool searchForMissingEpisodes = false,
    bool searchForCutoffUnmetEpisodes = false,
    bool includeSeasonImages = false,
  }) async =>
      _commandAddAuthor(
        _client,
        author: author,
        qualityProfile: qualityProfile,
        metadataProfile: metadataProfile,
        rootFolder: rootFolder,
        monitorType: monitorType,
        tags: tags,
        searchForMissingEpisodes: searchForMissingEpisodes,
        searchForCutoffUnmetEpisodes: searchForCutoffUnmetEpisodes,
      );*/

  /// Handler for [series/{id}](https://github.com/Readarr/Readarr/wiki/Series#deleteid).
  ///
  /// Delete the series with the given series ID.
  Future<void> delete({
    required int bookId,
    bool deleteFiles = false,
    bool addImportListExclusion = false,
  }) async =>
      _commandDeleteBook(
        _client,
        bookId: bookId,
        deleteFiles: deleteFiles,
        addImportListExclusion: addImportListExclusion,
      );

/*
  /// Handler for [series/{id}](https://github.com/Readarr/Readarr/wiki/Series#getid).
  ///
  /// Returns the series with the matching ID.
  Future<ReadarrAuthor> get({required int authorId}) async => _commandGetAuthor(
        _client,
        authorId: authorId,
      );
*/
  /// Handler for [series](https://github.com/Readarr/Readarr/wiki/Series#get).
  ///
  /// Returns a list of all series.
  Future<List<ReadarrBook>> getAll() async => _commandGetAllBooks(
        _client,
      );

/*
  /// Handler for [book]https://github.com/Readarr/Readarr/wiki/Series#put).
  ///
  /// Update an existing series.
  Future<ReadarrBook> update({
    required ReadarrBook author,
  }) async =>
      _commandUpdateAuthor(
        _client,
        author: author,
      );*/

  /// Handler for `book/monitor`.
  ///
  /// Sets the monitored state for the given episode IDs.
  Future<List<ReadarrBook>> setMonitored({
    required List<int> bookIds,
    required bool monitored,
  }) async =>
      _commandBookSetMonitored(
        _client,
        bookIds: bookIds,
        monitored: monitored,
      );
}
