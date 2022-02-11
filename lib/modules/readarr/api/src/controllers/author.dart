part of readarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to series within Readarr.
///
/// [ReadarrControllerAuthor] internally handles routing the HTTP client to the API calls.
class ReadarrControllerAuthor {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  ReadarrControllerAuthor(this._client);

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
      );

  /// Handler for [series/{id}](https://github.com/Readarr/Readarr/wiki/Series#deleteid).
  ///
  /// Delete the series with the given series ID.
  Future<void> delete({
    required int authorId,
    bool deleteFiles = false,
    bool addImportListExclusion = false,
  }) async =>
      _commandDeleteAuthor(
        _client,
        authorId: authorId,
        deleteFiles: deleteFiles,
        addImportListExclusion: addImportListExclusion,
      );

  /// Handler for [series/{id}](https://github.com/Readarr/Readarr/wiki/Series#getid).
  ///
  /// Returns the series with the matching ID.
  Future<ReadarrAuthor> get({required int authorId}) async => _commandGetAuthor(
        _client,
        authorId: authorId,
      );

  /// Handler for [series](https://github.com/Readarr/Readarr/wiki/Series#get).
  ///
  /// Returns a list of all series.
  Future<List<ReadarrAuthor>> getAll() async => _commandGetAllAuthors(
        _client,
      );

  /// Handler for [author]https://github.com/Readarr/Readarr/wiki/Series#put).
  ///
  /// Update an existing series.
  Future<ReadarrAuthor> update({
    required ReadarrAuthor author,
  }) async =>
      _commandUpdateAuthor(
        _client,
        author: author,
      );
}
