/// Dart library package to facilitate the communication to and from [Overseerr](https://overseerr.dev)'s API:
/// A request management and media discovery tool for the Plex ecosystem
///
/// This library gives access to [overseerr_commands], and is needed as the only entrypoint.
library overseerr;

// Imports
import 'package:dio/dio.dart';
import 'commands.dart';

// Exports
export 'commands.dart';
export 'models.dart';
export 'types.dart';
export 'utilities.dart';

/// The core class to handle all connections to Overseerr.
/// Gives you easy access to all implemented command handlers, initialized and ready to call.
///
/// [Overseerr] handles the creation of the initial [Dio] HTTP client & command handlers.
/// You can optionally use the factory `.from()` to define your own [Dio] HTTP client.
class Overseerr {
  /// Internal constructor
  Overseerr._internal({
    required this.httpClient,
    required this.requests,
    required this.status,
    required this.users,
  });

  /// Create a new Overseerr API connection manager to connection to your instance.
  /// This default factory/constructor will create the [Dio] HTTP client for you given the parameters.
  ///
  /// Required Parameters:
  /// - `host`: String that contains the protocol (http:// or https://), the host itself, and the base URL (if applicable)
  /// - `apiKey`: The API key fetched from Overseerr's web interface
  ///
  /// Optional Parameters:
  /// - `headers`: Map that contains additional headers that should be attached to all requests
  /// - `followRedirects`: If the HTTP client should follow URL redirects
  /// - `maxRedirects`: The maximum amount of redirects the client should follow (does nothing if `followRedirects` is false)
  factory Overseerr({
    required String host,
    required String apiKey,
    Map<String, dynamic>? headers,
    bool followRedirects = true,
    int maxRedirects = 5,
  }) {
    // Build the HTTP client
    Dio _dio = Dio(
      BaseOptions(
        baseUrl: host.endsWith('/') ? '${host}api/v1/' : '$host/api/v1/',
        headers: {
          'X-Api-Key': apiKey,
          if (headers != null) ...headers,
        },
        followRedirects: followRedirects,
        maxRedirects: maxRedirects,
      ),
    );
    return Overseerr._internal(
      httpClient: _dio,
      requests: OverseerrCommandHandler_Requests(_dio),
      status: OverseerrCommandHandler_Status(_dio),
      users: OverseerrCommandHandler_Users(_dio),
    );
  }

  /// Create a new Overseerr API connection manager to connection to your instance.
  ///
  /// This factory allows you to define your own [Dio] HTTP client.
  /// Please ensure you set [BaseOptions] to include:
  /// - `baseUrl`: The URL to your Overseerr instance
  /// - `queryParameters`: The key `apikey` with the value of your API key.
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
  factory Overseerr.from({
    required Dio client,
  }) {
    return Overseerr._internal(
      httpClient: client,
      requests: OverseerrCommandHandler_Requests(client),
      status: OverseerrCommandHandler_Status(client),
      users: OverseerrCommandHandler_Users(client),
    );
  }

  /// The [Dio] HTTP client built during initialization.
  ///
  /// Making changes to the [Dio] client should propogate to the command handlers, but is not recommended.
  /// The recommended way to make changes to the HTTP client is to use the `.from()` factory to build your own [Dio] HTTP client.
  final Dio httpClient;

  /// Command handler for all request command-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final OverseerrCommandHandler_Requests requests;

  /// Command handler for all status command-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final OverseerrCommandHandler_Status status;

  /// Command handler for all user command-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final OverseerrCommandHandler_Users users;
}
