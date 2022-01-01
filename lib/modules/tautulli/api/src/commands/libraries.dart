part of tautulli_commands;

/// Facilitates, encapsulates, and manages individual calls related to libraries within Tautulli.
///
/// [TautulliCommandHandlerLibraries] internally handles routing the HTTP client to the API calls.
class TautulliCommandHandlerLibraries {
  final Dio _client;

  /// Create a library command handler using an initialized [Dio] client.
  TautulliCommandHandlerLibraries(this._client);

  /// Handler for [delete_all_library_history](https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_all_library_history).
  ///
  /// Delete all Tautulli history for a specific library.
  ///
  /// Required Parameters:
  /// - `sectionId`: The ID of the Plex library section
  ///
  /// Optional Parameters:
  /// - `serverId`: The Plex server identifier of the library section
  /// - `rowIds`: Optional list of row IDs to delete
  Future<void> deleteAllLibraryHistory({
    required int sectionId,
    String? serverId,
    List<int>? rowIds,
  }) async =>
      _commandDeleteAllLibraryHistory(_client,
          sectionId: sectionId, serverId: serverId, rowIds: rowIds);

  /// Handler for [delete_library](https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_library).
  ///
  /// Delete a library section from Tautulli. Also erases all history for the library.
  ///
  /// Required Parameters:
  /// - `sectionId`: The ID of the Plex library section
  ///
  /// Optional Parameters:
  /// - `serverId`: The Plex server identifier of the library section
  /// - `rowIds`: Optional list of row IDs to delete
  Future<void> deleteLibrary({
    required int sectionId,
    String? serverId,
    List<int>? rowIds,
  }) async =>
      _commandDeleteLibrary(_client,
          sectionId: sectionId, serverId: serverId, rowIds: rowIds);

  /// Handler for [delete_recently_added](https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_recently_added).
  ///
  /// Flush out all of the recently added items in the database.
  Future<void> deleteRecentlyAdded() async =>
      _commandDeleteRecentlyAdded(_client);

  /// Handler for [edit_library](https://github.com/Tautulli/Tautulli/blob/master/API.md#edit_library).
  ///
  /// Update a library section on Tautulli.
  ///
  /// Required Parameters:
  /// - `sectionId`: The ID of the Plex library section
  ///
  /// Optional Parameters:
  /// - `customThumb`: URL to a custom thumbnail art
  /// - `customArt`: URL to a custom background art
  /// - `keepHistory`: Should history be tracked for this library section?
  Future<void> editLibrary({
    required int sectionId,
    String? customThumb,
    String? customArt,
    bool? keepHistory,
  }) async =>
      _commandEditLibrary(_client,
          sectionId: sectionId,
          customThumb: customThumb,
          customArt: customArt,
          keepHistory: keepHistory);

  /// Handler for [get_libraries_table](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_libraries_table).
  ///
  /// Get the data on the Tautulli libraries table.
  ///
  /// Optional Parameters:
  /// - `grouping`: Group data
  /// - `orderColumn`: The column order key for sorting the library records
  /// - `orderDirection`: The direction to sort the library records
  /// - `start`: Which row to start at (default: 0)
  /// - `length`: Number of records to return (default: 25)
  /// - `search`: A string to search for
  Future<TautulliLibrariesTable> getLibrariesTable({
    bool? grouping,
    TautulliLibrariesOrderColumn? orderColumn,
    TautulliOrderDirection? orderDirection,
    int? start,
    int? length,
    String? search,
  }) async =>
      _commandGetLibrariesTable(
        _client,
        grouping: grouping,
        orderColumn: orderColumn,
        orderDirection: orderDirection,
        start: start,
        length: length,
        search: search,
      );

  /// Handler for [get_libraries](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_libraries).
  ///
  /// Get a list of all libraries on your server.
  Future<List<TautulliLibrary>> getLibraries() async =>
      _commandGetLibraries(_client);

  /// Handler for [get_library](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_library).
  ///
  /// Get a library's details.
  ///
  /// Required Parameters:
  /// - `sectionId`: The library section ID in Plex.
  Future<TautulliSingleLibrary> getLibrary({
    required int sectionId,
  }) async =>
      _commandGetLibrary(_client, sectionId: sectionId);

  /// Handler for [get_library_media_info](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_library_media_info).
  ///
  /// Get the data on the Tautulli media info tables.
  ///
  /// Required Parameters:
  /// - `sectionId`: The library section ID in Plex, **OR**
  /// - `ratingKey`: A grandparent or parent rating key
  ///
  /// Optional parameters:
  /// - `sectionType`: The type of content to filter for
  /// - `orderColumn`: The column order key for sorting the media information records
  /// - `orderDirection`: The direction to sort the media information records
  /// - `start`: Which row to start at (default: 0)
  /// - `length`: Number of records to return (default: 25)
  /// - `search`: A string to search for
  /// - `refresh`: If true, refresh the media info table
  Future<TautulliLibraryMediaInfo> getLibraryMediaInfo({
    int? sectionId,
    int? ratingKey,
    TautulliSectionType? sectionType,
    TautulliOrderDirection? orderDirection,
    TautulliLibraryMediaInfoOrderColumn? orderColumn,
    int? start,
    int? length,
    String? search,
    bool? refresh,
  }) async =>
      _commandGetLibraryMediaInfo(
        _client,
        sectionId: sectionId,
        ratingKey: ratingKey,
        sectionType: sectionType,
        orderDirection: orderDirection,
        orderColumn: orderColumn,
        start: start,
        length: length,
        search: search,
        refresh: refresh,
      );

  /// Handler for [get_library_names](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_library_names).
  ///
  /// Get a list of library sections and IDs on the Plex Media Server.
  Future<List<TautulliLibraryName>> getLibraryNames() async =>
      _commandGetLibraryNames(_client);

  /// Handler for [get_library_user_stats](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_library_user_stats).
  ///
  /// Get a library's user statistics.
  ///
  /// Required Parameters:
  /// - `sectionId`: The library section ID in Plex
  ///
  /// Optional Parameters:
  /// - `grouping`: Group data
  Future<List<TautulliLibraryUserStats>> getLibraryUserStats({
    required int sectionId,
    bool? grouping,
  }) async =>
      _commandGetLibraryUserStats(_client,
          sectionId: sectionId, grouping: grouping);

  /// Handler for [get_library_watch_time_stats](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_library_watch_time_stats).
  ///
  /// Get a library's watch time statistics.
  ///
  /// Required Parameters:
  /// - `sectionId`: The library section ID in Plex
  ///
  /// Optional Parameters:
  /// - `grouping`: Group data
  /// - `queryDays`: List of days (integers) for which to fetch watch time statistics. If null, returns 0 (everything), 1, 7, and 30 days of coverage
  Future<List<TautulliLibraryWatchTimeStats>> getLibraryWatchTimeStats({
    required int sectionId,
    bool? grouping,
    List<int>? queryDays,
  }) async =>
      _commandGetLibraryWatchTimeStats(_client,
          sectionId: sectionId, grouping: grouping, queryDays: queryDays);

  /// Handler for [get_metadata](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_metadata).
  ///
  /// Get the metadata for a media item.
  ///
  /// Required Parameters:
  /// - `ratingKey`: Rating key of the content item
  Future<TautulliMetadata> getMetadata({
    required int ratingKey,
  }) async =>
      _commandGetMetadata(_client, ratingKey: ratingKey);

  /// Handler for [get_new_rating_keys](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_new_rating_keys).
  ///
  /// Get a list of new rating keys for the Plex Media Server of all of the item's parent/children.
  ///
  /// Required Parameters:
  /// - `ratingKey`: Rating key for the content
  /// - `mediaType`: The type of media
  ///
  /// *Because of the unpredictable structure of the returned data, the returned data remains in its original JSON/Map format.*
  Future<Map<String, dynamic>?> getNewRatingKeys({
    required int ratingKey,
    required TautulliMediaType mediaType,
  }) async =>
      _commandGetNewRatingKeys(_client,
          ratingKey: ratingKey, mediaType: mediaType);

  /// Handler for [get_old_rating_keys](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_old_rating_keys).
  ///
  /// Get a list of new rating keys for the Plex Media Server of all of the item's parent/children.
  ///
  /// Required Parameters:
  /// - `ratingKey`: Rating key for the content
  /// - `mediaType`: The type of media
  ///
  /// *Because of the unpredictable structure of the returned data, the returned data remains in its original JSON/Map format.*
  Future<Map<String, dynamic>?> getOldRatingKeys({
    required int ratingKey,
    required TautulliMediaType mediaType,
  }) async =>
      _commandGetOldRatingKeys(_client,
          ratingKey: ratingKey, mediaType: mediaType);

  /// Handler for [get_recently_added](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_recently_added).
  ///
  /// Get all items that were recently added to Plex.
  ///
  /// Required Parameters:
  /// - `count`: Number of items to return
  ///
  /// Optional Parameters:
  /// - `start`: Starting index within the table
  /// - `mediaType`: Filter results to only this media type
  /// - `sectionId`: Filter results to only the library with this section ID
  Future<List<TautulliRecentlyAdded>> getRecentlyAdded({
    required int count,
    int? start,
    TautulliMediaType? mediaType,
    int? sectionId,
  }) async =>
      _commandGetRecentlyAdded(_client,
          count: count,
          start: start,
          mediaType: mediaType,
          sectionId: sectionId);

  /// Handler for [get_synced_items](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_synced_items).
  ///
  /// Get a list of synced items on the Plex Media Server.
  ///
  /// Optional Parameters:
  /// - `machineId`: The machine identifier to check for synced items
  /// - `userId`: The user ID to fetch synced items for
  Future<List<TautulliSyncedItem>> getSyncedItems({
    String? machineId,
    int? userId,
  }) async =>
      _commandGetSyncedItems(_client, machineId: machineId, userId: userId);

  /// Handler for [refresh_libraries_list](https://github.com/Tautulli/Tautulli/blob/master/API.md#refresh_libraries_list).
  ///
  /// Refresh the Tautulli libraries list.
  Future<void> refreshLibrariesList() async =>
      _commandRefreshLibrariesList(_client);

  /// Handler for [search](https://github.com/Tautulli/Tautulli/blob/master/API.md#search).
  ///
  /// Get search results from the Plex Media Server.
  ///
  /// Required Parameters:
  /// - `query`: The query string to search for
  ///
  /// Optional Parameters:
  /// - `limit`: The maximum amount of items to return per media type
  Future<TautulliSearch> search({
    required String query,
    int? limit,
  }) async =>
      _commandSearch(_client, query: query, limit: limit);

  /// Handler for [update_metadata_details](https://github.com/Tautulli/Tautulli/blob/master/API.md#update_metadata_details).
  ///
  /// Update the metadata in the Tautulli database by matching rating keys. Also updates all parents or children of the media item if it is a show/season/episode or artist/album/track.
  ///
  /// Required Parameters:
  /// - `oldRatingKey`: Identifier key for the old rating key
  /// - `newRatingKey`: Identifier key for the new rating key
  /// - `mediaType`: [TautulliMediaType] value for the media type
  Future<void> updateMetadataDetails({
    required int oldRatingKey,
    required int newRatingKey,
    required TautulliMediaType mediaType,
  }) async =>
      _commandUpdateMetadataDetails(_client,
          oldRatingKey: oldRatingKey,
          newRatingKey: newRatingKey,
          mediaType: mediaType);

  /// Handler for [undelete_library](https://github.com/Tautulli/Tautulli/blob/master/API.md#undelete_library).
  ///
  /// Restore a deleted library section to Tautulli.
  ///
  /// Required Parameters:
  /// - `sectionId`: The ID of the Plex library section
  /// - `sectionName`: The name of the Plex library section
  Future<void> undeleteLibrary({
    required int sectionId,
    required String sectionName,
  }) async =>
      _commandUndeleteLibrary(_client,
          sectionId: sectionId, sectionName: sectionName);
}
