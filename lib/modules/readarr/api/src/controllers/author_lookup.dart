part of readarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to series lookup within Readarr.
///
/// [ReadarrControllerAuthorLookup] internally handles routing the HTTP client to the API calls.
class ReadarrControllerAuthorLookup {
  final Dio _client;

  /// Create a series command handler using an initialized [Dio] client.
  ReadarrControllerAuthorLookup(this._client);

  /// Handler for [series/lookup](https://github.com/Readarr/Readarr/wiki/Series-Lookup#get).
  ///
  /// Searches for new shows on TheTVDB.com utilizing readarr.tv's caching and augmentation proxy.
  ///
  /// Required Parameters:
  /// - `term`: Term/words to search for
  Future<List<ReadarrAuthor>> get({
    required String term,
  }) async =>
      _commandGetSeriesLookup(_client, term: term);
}
