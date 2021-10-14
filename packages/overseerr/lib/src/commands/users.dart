part of overseerr_commands;

/// Facilitates, encapsulates, and manages individual calls related to users within Overseerr.
///
/// [OverseerrCommandHandler_Users] internally handles routing the HTTP client to the API calls.
class OverseerrCommandHandler_Users {
  final Dio _client;

  /// Create a command handler using an initialized [Dio] client.
  OverseerrCommandHandler_Users(this._client);

  /// Handler for [user](https://api-docs.overseerr.dev/#/users/get_user).
  ///
  /// Returns all users.
  ///
  /// - [take] a specific amount of users
  /// - [skip] to a different page
  /// - [sort] the incoming list
  Future<OverseerrUserPage> getUsers({
    int? take,
    int? skip,
    OverseerrUserSortType? sort,
  }) async =>
      _commandGetUsers(
        _client,
        take: take,
        skip: skip,
        sort: sort,
      );

  /// Handler for [user/${userId}](https://api-docs.overseerr.dev/#/users/get_user__userId_).
  ///
  /// Returns a single user.
  Future<OverseerrUser> getUserByID({
    required int id,
  }) async =>
      _commandGetUser(
        _client,
        id: id,
      );

  /// Handler for [user/${userId}/quota](https://api-docs.overseerr.dev/#/users/get_user__userId__quota).
  ///
  /// Returns quota details for a user.
  Future<OverseerrUserQuota> getUserQuota({
    required int id,
  }) async =>
      _commandGetUserQuota(
        _client,
        id: id,
      );
}
