part of tautulli_commands;

/// Facilitates, encapsulates, and manages individual calls related to users within Tautulli.
///
/// [TautulliCommandHandlerUsers] internally handles routing the HTTP client to the API calls.
class TautulliCommandHandlerUsers {
  final Dio _client;

  /// Create a user command handler using an initialized [Dio] client.
  TautulliCommandHandlerUsers(this._client);

  /// Handler for [delete_all_user_history](https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_all_user_history).
  ///
  /// Delete all Tautulli history for a specific user.
  ///
  /// Required Parameters:
  /// - `userId`: The ID of the Plex user
  ///
  /// Optional Parameters:
  /// - `rowIds`: Optional list of row IDs to delete
  Future<void> deleteAllUserHistory({
    required int userId,
    List<int>? rowIds,
  }) async =>
      _commandDeleteAllUserHistory(_client, userId: userId, rowIds: rowIds);

  /// Handler for [delete_user](https://github.com/Tautulli/Tautulli/blob/master/API.md#delete_user).
  ///
  /// Delete a user from Tautulli. Also erases all history for the user.
  ///
  /// Required Parameters:
  /// - `userId`: The ID of the Plex user
  ///
  /// Optional Parameters:
  /// - `rowIds`: Optional list of row IDs to delete
  Future<void> deleteUser({
    required int userId,
    List<int>? rowIds,
  }) async =>
      _commandDeleteUser(_client, userId: userId, rowIds: rowIds);

  /// Handler for [edit_user](https://github.com/Tautulli/Tautulli/blob/master/API.md#edit_user).
  ///
  /// Update a user on Tautulli.
  ///
  /// Required Parameters:
  /// - `userId`: The ID of the Plex user
  ///
  /// Optional Parameters:
  /// - `friendlyName`: A friendly name to set for the user
  /// - `customThumb`: A URL to set the custom thumbnail to
  /// - `keepHistory`: Set if you should keep the history for the user
  /// - `allowGuest`: Set if you want to allow Tautulli guest access for the user
  Future<void> editUser({
    required int userId,
    String? friendlyName,
    String? customThumb,
    bool? keepHistory,
    bool? allowGuest,
  }) async =>
      _commandEditUser(_client,
          userId: userId,
          friendlyName: friendlyName,
          customThumb: customThumb,
          keepHistory: keepHistory,
          allowGuest: allowGuest);

  /// Handler for [get_user](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_user).
  ///
  /// Get a user's details.
  ///
  /// Required Parameters:
  /// - `userId`: The user's ID
  Future<TautulliUser> getUser({
    required int userId,
  }) async =>
      _commandGetUser(_client, userId: userId);

  /// Handler for [get_user_logins](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_user_logins).
  ///
  /// Get the data on Tautulli user login table.
  ///
  /// Optional Parameters:
  /// - `userId`: A specific user to fetch login records for
  /// - `orderColumn`: The column order key for sorting the login records
  /// - `orderDirection`: The direction to sort the login records
  /// - `start`: Which row to start at (default: 0)
  /// - `length`: Number of records to return (default: 25)
  /// - `search`: A string to search for
  Future<TautulliUserLogins> getUserLogins({
    int? userId,
    TautulliUserLoginsOrderColumn? orderColumn,
    TautulliOrderDirection? orderDirection,
    int? start,
    int? length,
    String? search,
  }) async =>
      _commandGetUserLogins(
        _client,
        userId: userId,
        orderColumn: orderColumn,
        orderDirection: orderDirection,
        start: start,
        length: length,
        search: search,
      );

  /// Handler for [get_user_ips](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_user_ips).
  ///
  /// Get the data on Tautulli users IP table.
  ///
  /// Required Parameters:
  /// - `userId`: A specific user to fetch IP address records for
  ///
  /// Optional Parameters:
  /// - `orderColumn`: The column order key for sorting the IP address records
  /// - `orderDirection`: The direction to sort the IP address records
  /// - `start`: Which row to start at (default: 0)
  /// - `length`: Number of records to return (default: 25)
  /// - `search`: A string to search for
  Future<TautulliUserIPs> getUserIPs({
    required int userId,
    TautulliUserIPsOrderColumn? orderColumn,
    TautulliOrderDirection? orderDirection,
    int? start,
    int? length,
    String? search,
  }) async =>
      _commandGetUserIPs(
        _client,
        userId: userId,
        orderColumn: orderColumn,
        orderDirection: orderDirection,
        start: start,
        length: length,
        search: search,
      );

  /// Handler for [get_user_names](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_user_names).
  ///
  /// Get a list of all user and user IDs.
  Future<List<TautulliUserName>> getUserNames() async =>
      _commandGetUserNames(_client);

  /// Handler for [get_user_player_stats](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_user_player_stats).
  ///
  /// Get a user's player statistics.
  ///
  /// Required Parameters:
  /// - `userId`: The ID of the Plex user
  ///
  /// Optional Parameters:
  /// - `grouping`: Group data
  Future<List<TautulliUserPlayerStats>> getUserPlayerStats({
    required int userId,
    bool? grouping,
  }) async =>
      _commandGetUserPlayerStats(_client, userId: userId, grouping: grouping);

  /// Handler for [get_user_watch_time_stats](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_user_watch_time_stats).
  ///
  /// Get a user's watch time statistics.
  ///
  /// Required Parameters:
  /// - `userId`: The ID of the Plex user
  ///
  /// Optional Parameters:
  /// - `grouping`: Group data
  /// - `queryDays`: List of days (integers) for which to fetch watch time statistics
  Future<List<TautulliUserWatchTimeStats>> getUserWatchTimeStats({
    required int userId,
    bool? grouping,
    List<int>? queryDays,
  }) async =>
      _commandGetUserWatchTimeStats(_client,
          userId: userId, grouping: grouping, queryDays: queryDays);

  /// Handler for [get_users](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_users).
  ///
  /// Get a list of all users that have access to your server.
  Future<List<TautulliUser>> getUsers() async => _commandGetUsers(_client);

  /// Handler for [get_users_table](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_users_table).
  ///
  /// Get the data on Tautulli users table.
  ///
  /// Optional Parameters:
  /// - `grouping`: Group users
  /// - `orderColumn`: The column order key for sorting the user records
  /// - `orderDirection`: The direction to sort the user records
  /// - `start`: Which row to start at (default: 0)
  /// - `length`: Number of records to return (default: 25)
  /// - `search`: A string to search for
  Future<TautulliUsersTable> getUsersTable({
    bool? grouping,
    TautulliUsersOrderColumn? orderColumn,
    TautulliOrderDirection? orderDirection,
    int? start,
    int? length,
    String? search,
  }) async =>
      _commandGetUsersTable(
        _client,
        grouping: grouping,
        orderColumn: orderColumn,
        orderDirection: orderDirection,
        start: start,
        length: length,
        search: search,
      );

  /// Handler for [refresh_users_list](https://github.com/Tautulli/Tautulli/blob/master/API.md#refresh_users_list).
  ///
  /// Refresh the Tautulli users list.
  Future<void> refreshUsersList() async => _commandRefreshUsersList(_client);

  /// Handler for [undelete_user](https://github.com/Tautulli/Tautulli/blob/master/API.md#undelete_user).
  ///
  /// Restore a deleted user to Tautulli.
  ///
  /// Required Parameters:
  /// - `userId`: Identifier of the Plex user
  /// - `username`: Username of the Plex user
  Future<void> undeleteUser({
    required int userId,
    required String username,
  }) async =>
      _commandUndeleteUser(_client, userId: userId, username: username);
}
