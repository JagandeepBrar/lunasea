/// Dart library package to facilitate the connection to and from [Tautulli](https://tautulli.com)'s API:
/// a Python based monitoring and tracking tool for Plex Media Server.
///
/// This library gives access to [tautulli_commands], [tautulli_models], and [tautulli_types], and is needed as the only entrypoint.
library tautulli;

// Imports
import 'package:dio/dio.dart';
import 'package:lunasea/api/tautulli/commands.dart';

/// The core class to handle all connections to Tautulli.
/// Gives you easy access to all implemented command handlers, initialized and ready to call.
///
/// [TautulliAPI] handles the creation of the initial [Dio] HTTP client & command handlers.
/// You can optionally use the factory `.from()` to define your own [Dio] HTTP client.
class TautulliAPI {
  /// Internal constructor
  TautulliAPI._internal({
    required this.httpClient,
    required this.activity,
    required this.history,
    required this.libraries,
    required this.miscellaneous,
    required this.notifications,
    required this.system,
    required this.users,
  });

  /// Create a new Tautulli API connection manager to connection to your instance.
  /// This default factory/constructor will create the [Dio] HTTP client for you given the parameters.
  ///
  /// Required Parameters:
  /// - `host`: String that contains the protocol (http:// or https://), the host itself, and the base URL (if applicable)
  /// - `apiKey`: The API key fetched from Tautulli's web interface
  ///
  /// Optional Parameters:
  /// - `headers`: Map that contains additional headers that should be attached to all requests
  /// - `followRedirects`: If the HTTP client should follow URL redirects
  /// - `maxRedirects`: The maximum amount of redirects the client should follow (does nothing if `followRedirects` is false)
  factory TautulliAPI({
    required String host,
    required String apiKey,
    Map<String, dynamic>? headers,
    bool followRedirects = true,
    int maxRedirects = 5,
  }) {
    // Build the HTTP client
    Dio _dio = Dio(
      BaseOptions(
        baseUrl: host.endsWith('/') ? '${host}api/v2' : '$host/api/v2',
        queryParameters: {
          'apikey': apiKey,
        },
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        headers: headers,
        followRedirects: followRedirects,
        maxRedirects: maxRedirects,
      ),
    );
    return TautulliAPI._internal(
      httpClient: _dio,
      activity: TautulliCommandHandlerActivity(_dio),
      history: TautulliCommandHandlerHistory(_dio),
      libraries: TautulliCommandHandlerLibraries(_dio),
      miscellaneous: TautulliCommandHandlerMiscellaneous(_dio),
      notifications: TautulliCommandHandlerNotifications(_dio),
      system: TautulliCommandHandlerSystem(_dio),
      users: TautulliCommandHandlerUsers(_dio),
    );
  }

  /// Create a new Tautulli API connection manager to connection to your instance.
  ///
  /// This factory allows you to define your own [Dio] HTTP client.
  ///
  /// Required Parameters:
  /// - `client`: A [Dio] instance
  ///
  /// Please ensure you set [BaseOptions] to include:
  /// - `baseUrl`: The URL to your Tautulli instance
  /// - `queryParameters`: The key `apikey` with the value of your API key
  ///
  /// Without these you will not be able to achieve a successful connection. See example below for bare minimum [Dio] configuration:
  /// ```dart
  /// Dio(
  ///     BaseOptions(
  ///         baseUrl: '<your instance URL>',
  ///         queryParameters: {
  ///             'apikey': '<your API key>',
  ///         },
  ///     ),
  /// );
  /// ```
  factory TautulliAPI.from({
    required Dio client,
  }) {
    return TautulliAPI._internal(
      httpClient: client,
      activity: TautulliCommandHandlerActivity(client),
      history: TautulliCommandHandlerHistory(client),
      libraries: TautulliCommandHandlerLibraries(client),
      miscellaneous: TautulliCommandHandlerMiscellaneous(client),
      notifications: TautulliCommandHandlerNotifications(client),
      system: TautulliCommandHandlerSystem(client),
      users: TautulliCommandHandlerUsers(client),
    );
  }

  /// The [Dio] HTTP client built during initialization.
  ///
  /// Making changes to the [Dio] client should propogate to the command handlers, but is not recommended.
  /// The recommended way to make changes to the HTTP client is to use the `.from()` factory to build your own [Dio] HTTP client.
  final Dio httpClient;

  /// Command handler for all activity-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final TautulliCommandHandlerActivity activity;

  /// Command handler for all history-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final TautulliCommandHandlerHistory history;

  /// Command handler for all library-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final TautulliCommandHandlerLibraries libraries;

  /// Command handler for all misc-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final TautulliCommandHandlerMiscellaneous miscellaneous;

  /// Command handler for all notification-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final TautulliCommandHandlerNotifications notifications;

  /// Command handler for all system-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final TautulliCommandHandlerSystem system;

  /// Command handler for all user-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final TautulliCommandHandlerUsers users;
}
