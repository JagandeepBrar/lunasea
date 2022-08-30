part of tautulli_commands;

/// Facilitates, encapsulates, and manages individual calls related to history within Tautulli.
///
/// [TautulliCommandHandlerHistory] internally handles routing the HTTP client to the API calls.
class TautulliCommandHandlerHistory {
  final Dio _client;

  /// Create a history command handler using an initialized [Dio] client.
  TautulliCommandHandlerHistory(this._client);

  /// Handler for [delete_history](https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_history).
  ///
  /// Delete history rows from Tautulli.
  ///
  /// Required Parameters:
  /// - `rowIds`: List of row IDs to delete
  Future<void> deleteHistory({
    required List<int> rowIds,
  }) async =>
      _commandDeleteHistory(_client, rowIds: rowIds);

  /// Handler for [get_history](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_history).
  ///
  /// Get the Tautulli history.
  ///
  /// Optional Parameters:
  /// - `grouping`: Group data
  /// - `user`: User's name
  /// - `userId`: User's ID
  /// - `ratingKey`: Identifier/rating key for the content itself
  /// - `parentRatingKey`: Identifier/rating key for the content's parent
  /// - `grandparentRatingKey`: Identifier/rating key for the content's grandparent
  /// - `startDate`: String DateTime format structured as "YYYY-MM-DD"
  /// - `sectionId`: Section ID to fetch history for
  /// - `mediaType`: Type of media to fetch history for
  /// - `transcodeDecision`: To fetch history only for records with a specific transcoding decision
  /// - `guid`: Plex GUID for an item
  /// - `orderColumn`: The column order key for sorting the history records
  /// - `orderDirection`: The direction to sort the history records
  /// - `start`: Which row to start at (default: 0)
  /// - `length`: Number of records to return (default: 25)
  /// - `search`: A string to search for
  Future<TautulliHistory> getHistory({
    bool? grouping,
    String? user,
    int? userId,
    int? ratingKey,
    int? parentRatingKey,
    int? grandparentRatingKey,
    String? startDate,
    int? sectionId,
    TautulliMediaType? mediaType,
    TautulliTranscodeDecision? transcodeDecision,
    String? guid,
    TautulliHistoryOrderColumn? orderColumn,
    TautulliOrderDirection? orderDirection,
    int? start,
    int? length,
    String? search,
  }) async =>
      _commandGetHistory(
        _client,
        grouping: grouping,
        user: user,
        userId: userId,
        ratingKey: ratingKey,
        parentRatingKey: parentRatingKey,
        grandparentRatingKey: grandparentRatingKey,
        startDate: startDate,
        sectionId: sectionId,
        mediaType: mediaType,
        transcodeDecision: transcodeDecision,
        guid: guid,
        orderColumn: orderColumn,
        orderDirection: orderDirection,
        start: start,
        length: length,
        search: search,
      );

  /// Handler for [get_home_stats](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_home_stats).
  ///
  /// Get the homepage watch statistics.
  ///
  /// Optional Parameters:
  /// - `grouping`: Group data
  /// - `timeRange`: The amount of days to fetch data for. Minimum value of 1, anything below 1 will return the default time range (30 days)
  /// - `statsType`: What type of statistics to fetch
  /// - `statsCount`: The number of top items in the lists
  Future<List<TautulliHomeStats>> getHomeStats({
    bool? grouping,
    int? timeRange,
    TautulliStatsType? statsType,
    int? statsCount,
  }) async =>
      _commandGetHomeStats(_client,
          grouping: grouping,
          timeRange: timeRange,
          statsType: statsType,
          statsCount: statsCount);

  /// Handler for [get_plays_by_date](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_date).
  ///
  /// Get graph data by date.
  ///
  /// Optional Parameters:
  /// - `timeRange`: The amount of days to fetch data for. Minimum value of 1, anything below 1 will return the default time range (30 days)
  /// - `userId`: User ID to filter the data for
  /// - `grouping`: Group data
  /// - `yAxis`: What key to use for the Y-Axis in the data
  Future<TautulliGraphData> getPlaysByDate({
    int? timeRange,
    int? userId,
    bool? grouping,
    TautulliGraphYAxis? yAxis,
  }) async =>
      _commandGetPlaysByDate(_client,
          timeRange: timeRange,
          userId: userId,
          grouping: grouping,
          yAxis: yAxis);

  /// Handler for [get_plays_by_dayofweek](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_dayofweek).
  ///
  /// Get graph data by day of the week.
  ///
  /// Optional Parameters:
  /// - `timeRange`: The amount of days to fetch data for. Minimum value of 1, anything below 1 will return the default time range (30 days)
  /// - `userId`: User ID to filter the data for
  /// - `grouping`: Group data
  /// - `yAxis`: What key to use for the Y-Axis in the data
  Future<TautulliGraphData> getPlaysByDayOfWeek({
    int? timeRange,
    int? userId,
    bool? grouping,
    TautulliGraphYAxis? yAxis,
  }) async =>
      _commandGetPlaysByDayOfWeek(_client,
          timeRange: timeRange,
          userId: userId,
          grouping: grouping,
          yAxis: yAxis);

  /// Handler for [get_plays_by_hourofday](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_hourofday).
  ///
  /// Get graph data by hour of the day.
  ///
  /// Optional Parameters:
  /// - `timeRange`: The amount of days to fetch data for. Minimum value of 1, anything below 1 will return the default time range (30 days)
  /// - `userId`: User ID to filter the data for
  /// - `grouping`: Group data
  /// - `yAxis`: What key to use for the Y-Axis in the data
  Future<TautulliGraphData> getPlaysByHourOfDay({
    int? timeRange,
    int? userId,
    bool? grouping,
    TautulliGraphYAxis? yAxis,
  }) async =>
      _commandGetPlaysByHourOfDay(_client,
          timeRange: timeRange,
          userId: userId,
          grouping: grouping,
          yAxis: yAxis);

  /// Handler for [get_plays_by_source_resolution](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_source_resolution).
  ///
  /// Get graph data by source resolution.
  ///
  /// Optional Parameters:
  /// - `timeRange`: The amount of days to fetch data for. Minimum value of 1, anything below 1 will return the default time range (30 days)
  /// - `userId`: User ID to filter the data for
  /// - `grouping`: Group data
  /// - `yAxis`: What key to use for the Y-Axis in the data
  Future<TautulliGraphData> getPlaysBySourceResolution({
    int? timeRange,
    int? userId,
    bool? grouping,
    TautulliGraphYAxis? yAxis,
  }) async =>
      _commandGetPlaysBySourceResolution(_client,
          timeRange: timeRange,
          userId: userId,
          grouping: grouping,
          yAxis: yAxis);

  /// Handler for [get_plays_by_stream_resolution](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_stream_resolution).
  ///
  /// Get graph data by stream resolution.
  ///
  /// Optional Parameters:
  /// - `timeRange`: The amount of days to fetch data for. Minimum value of 1, anything below 1 will return the default time range (30 days)
  /// - `userId`: User ID to filter the data for
  /// - `grouping`: Group data
  /// - `yAxis`: What key to use for the Y-Axis in the data
  Future<TautulliGraphData> getPlaysByStreamResolution({
    int? timeRange,
    int? userId,
    bool? grouping,
    TautulliGraphYAxis? yAxis,
  }) async =>
      _commandGetPlaysByStreamResolution(_client,
          timeRange: timeRange,
          userId: userId,
          grouping: grouping,
          yAxis: yAxis);

  /// Handler for [get_plays_by_stream_type](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_stream_type).
  ///
  /// Get graph data by stream type by date.
  ///
  /// Optional Parameters:
  /// - `timeRange`: The amount of days to fetch data for. Minimum value of 1, anything below 1 will return the default time range (30 days)
  /// - `userId`: User ID to filter the data for
  /// - `grouping`: Group data
  /// - `yAxis`: What key to use for the Y-Axis in the data
  Future<TautulliGraphData> getPlaysByStreamType({
    int? timeRange,
    int? userId,
    bool? grouping,
    TautulliGraphYAxis? yAxis,
  }) async =>
      _commandGetPlaysByStreamType(_client,
          timeRange: timeRange,
          userId: userId,
          grouping: grouping,
          yAxis: yAxis);

  /// Handler for [get_plays_by_top_10_platforms](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_top_10_platforms).
  ///
  /// Get graph data by top 10 platforms.
  ///
  /// Optional Parameters:
  /// - `timeRange`: The amount of days to fetch data for. Minimum value of 1, anything below 1 will return the default time range (30 days)
  /// - `userId`: User ID to filter the data for
  /// - `grouping`: Group data
  /// - `yAxis`: What key to use for the Y-Axis in the data
  Future<TautulliGraphData> getPlaysByTopTenPlatforms({
    int? timeRange,
    int? userId,
    bool? grouping,
    TautulliGraphYAxis? yAxis,
  }) async =>
      _commandGetPlaysByTopTenPlatforms(_client,
          timeRange: timeRange,
          userId: userId,
          grouping: grouping,
          yAxis: yAxis);

  /// Handler for [get_plays_by_top_10_users](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_by_top_10_users).
  ///
  /// Get graph data by top 10 users.
  ///
  /// Optional Parameters:
  /// - `timeRange`: The amount of days to fetch data for. Minimum value of 1, anything below 1 will return the default time range (30 days)
  /// - `userId`: User ID to filter the data for
  /// - `grouping`: Group data
  /// - `yAxis`: What key to use for the Y-Axis in the data
  Future<TautulliGraphData> getPlaysByTopTenUsers({
    int? timeRange,
    int? userId,
    bool? grouping,
    TautulliGraphYAxis? yAxis,
  }) async =>
      _commandGetPlaysByTopTenUsers(_client,
          timeRange: timeRange,
          userId: userId,
          grouping: grouping,
          yAxis: yAxis);

  /// Handler for [get_plays_per_month](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plays_per_month).
  ///
  /// Get graph data by month.
  ///
  /// Optional Parameters:
  /// - `timeRange`: The amount of months to fetch data for. Minimum value of 1, anything below 1 will return the default time range (12 months)
  /// - `userId`: User ID to filter the data for
  /// - `grouping`: Group data
  /// - `yAxis`: What key to use for the Y-Axis in the data
  Future<TautulliGraphData> getPlaysPerMonth({
    int? timeRange,
    int? userId,
    bool? grouping,
    TautulliGraphYAxis? yAxis,
  }) async =>
      _commandGetPlaysPerMonth(_client,
          timeRange: timeRange,
          userId: userId,
          grouping: grouping,
          yAxis: yAxis);

  /// Handler for [get_stream_data](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_stream_data).
  ///
  /// Get the stream details from history or current stream.
  ///
  /// Required Parameters:
  /// - `sessionKey`: The session key of the current stream, **OR**
  /// - `rowId`: The row ID number for the history item.
  Future<TautulliStreamData> getStreamData({
    int? sessionKey,
    int? rowId,
  }) async =>
      _commandGetStreamData(_client, rowId: rowId, sessionKey: sessionKey);

  /// Handler for [get_stream_type_by_top_10_users](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_stream_type_by_top_10_users).
  ///
  /// Get graph data by stream type by top 10 users.
  ///
  /// Optional Parameters:
  /// - `timeRange`: The amount of days to fetch data for. Minimum value of 1, anything below 1 will return the default time range (30 days)
  /// - `userId`: User ID to filter the data for
  /// - `grouping`: Group data
  /// - `yAxis`: What key to use for the Y-Axis in the data
  Future<TautulliGraphData> getStreamTypeByTopTenUsers({
    int? timeRange,
    int? userId,
    bool? grouping,
    TautulliGraphYAxis? yAxis,
  }) async =>
      _commandGetStreamTypeByTopTenUsers(_client,
          timeRange: timeRange,
          userId: userId,
          grouping: grouping,
          yAxis: yAxis);

  /// Handler for [get_stream_type_by_top_10_platforms](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_stream_type_by_top_10_platforms).
  ///
  /// Get graph data by stream type by top 10 platforms.
  ///
  /// Optional Parameters:
  /// - `timeRange`: The amount of days to fetch data for. Minimum value of 1, anything below 1 will return the default time range (30 days)
  /// - `userId`: User ID to filter the data for
  /// - `grouping`: Group data
  /// - `yAxis`: What key to use for the Y-Axis in the data
  Future<TautulliGraphData> getStreamTypeByTopTenPlatforms({
    int? timeRange,
    int? userId,
    bool? grouping,
    TautulliGraphYAxis? yAxis,
  }) async =>
      _commandGetStreamTypeByTopTenPlatforms(_client,
          timeRange: timeRange,
          userId: userId,
          grouping: grouping,
          yAxis: yAxis);
}
