part of overseerr_commands;

/// Facilitates, encapsulates, and manages individual calls related to requests within Overseerr.
///
/// [OverseerrCommandHandler_Requests] internally handles routing the HTTP client to the API calls.
class OverseerrCommandHandler_Requests {
  final Dio _client;

  /// Create a command handler using an initialized [Dio] client.
  OverseerrCommandHandler_Requests(this._client);

  /// Handler for [request/count](https://api-docs.overseerr.dev/#/request/get_request_count).
  ///
  /// Returns the number of pending and approved requests.
  Future<OverseerrRequestCount> getRequestCount() async =>
      _commandGetRequestCount(_client);

  /// Handler for [request/${requestId}](https://api-docs.overseerr.dev/#/request/get_request__requestId_).
  ///
  /// Returns a specific media request.
  Future<OverseerrRequest> getRequestByID({
    required int id,
  }) async =>
      _commandGetRequest(
        _client,
        id: id,
      );

  /// Handler for [request](https://api-docs.overseerr.dev/#/request/get_request).
  ///
  /// Returns all requests.
  ///
  /// - [take] a specific amount of requests
  /// - [skip] to a different page
  /// - [sort] the incoming list
  /// - [filter] the incoming list
  /// - [requestBy] the given user
  Future<OverseerrRequestPage> getRequests({
    int? take,
    int? skip,
    OverseerrRequestFilterType? filter,
    OverseerrRequestSortType? sort,
    OverseerrUser? requestedBy,
  }) async =>
      _commandGetRequests(
        _client,
        take: take,
        skip: skip,
        sort: sort,
        filter: filter,
        requestedBy: requestedBy,
      );
}
