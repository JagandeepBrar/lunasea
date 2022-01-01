part of radarr_commands;

/// Facilitates, encapsulates, and manages individual calls related to import lists within Radarr.
///
/// [RadarrCommandHandlerImportList] internally handles routing the HTTP client to the API calls.
class RadarrCommandHandlerImportList {
  final Dio _client;

  /// Create a command handler using an initialized [Dio] client.
  RadarrCommandHandlerImportList(this._client);

  /// Handler for [importlist/{id}](https://radarr.video/docs/api/#/Import%20Lists/get-importlist-id).
  ///
  /// Returns a single import list.
  ///
  /// Required Parameters:
  /// - `listId`: Import list identifier
  Future<RadarrImportList> get({required int listId}) async =>
      _commandGetImportList(_client, listId: listId);

  /// Handler for [impostlist](https://radarr.video/docs/api/#/Import%20Lists/get-importList).
  ///
  /// Returns a list of all import lists.
  Future<List<RadarrImportList>> getAll() async =>
      _commandGetAllImportLists(_client);

  /// Handler for `impostlist/movie`.
  ///
  /// Returns a list of movies from the import list.
  ///
  /// Optional Parameters:
  /// - `includeRecommendations`: Include recommendations from Radarr
  Future<List<RadarrMovie>> getMovies({bool? includeRecommendations}) async =>
      _commandGetImportListMovies(_client,
          includeRecommendations: includeRecommendations);
}
