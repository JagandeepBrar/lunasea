/// Dart library package to facilitate the connection to and from [Tautulli](https://tautulli.com)'s API:
/// a Python based monitoring and tracking tool for Plex Media Server.
/// 
/// This library gives access to [tautulli_commands], [tautulli_models], and [tautulli_types], and is needed as the only entrypoint.
library tautulli;

// Imports
import 'package:dio/dio.dart';
import 'commands.dart';

// Exports
export 'commands.dart';
export 'models.dart';
export 'types.dart';
export 'utilities.dart';

/// The core class to handle all connections to Tautulli.
/// Gives you easy access to all implemented command handlers, initialized and ready to call.
/// 
/// [Tautulli] handles the creation of the initial [Dio] HTTP client & command handlers.
/// You can optionally use the factory `.from()` to define your own [Dio] HTTP client.
class Tautulli {
    /// Internal constructor
    Tautulli._internal({
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
    factory Tautulli({
        required String host,
        required String apiKey,
        Map<String, dynamic>? headers,
        bool followRedirects = true,
        int maxRedirects = 5,
    }) {
        // Build the HTTP client
        Dio _dio = Dio(
            BaseOptions(
                baseUrl: host.endsWith('/')
                    ? '${host}api/v2'
                    : '$host/api/v2',
                queryParameters: {
                    'apikey': apiKey,
                },
                headers: headers,
                followRedirects: followRedirects,
                maxRedirects: maxRedirects,
            ),
        );
        return Tautulli._internal(
            httpClient: _dio,
            activity: TautulliCommandHandler_Activity(_dio),
            history: TautulliCommandHandler_History(_dio),
            libraries: TautulliCommandHandler_Libraries(_dio),
            miscellaneous: TautulliCommandHandler_Miscellaneous(_dio),
            notifications: TautulliCommandHandler_Notifications(_dio),
            system: TautulliCommandHandler_System(_dio),
            users: TautulliCommandHandler_Users(_dio),
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
    factory Tautulli.from({
        required Dio client,
    }) {
        return Tautulli._internal(
            httpClient: client,
            activity: TautulliCommandHandler_Activity(client),
            history: TautulliCommandHandler_History(client),
            libraries: TautulliCommandHandler_Libraries(client),
            miscellaneous: TautulliCommandHandler_Miscellaneous(client),
            notifications: TautulliCommandHandler_Notifications(client),
            system: TautulliCommandHandler_System(client),
            users: TautulliCommandHandler_Users(client),
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
    final TautulliCommandHandler_Activity activity;
    /// Command handler for all history-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final TautulliCommandHandler_History history;
    /// Command handler for all library-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final TautulliCommandHandler_Libraries libraries;
    /// Command handler for all misc-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final TautulliCommandHandler_Miscellaneous miscellaneous;
    /// Command handler for all notification-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final TautulliCommandHandler_Notifications notifications;
    /// Command handler for all system-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final TautulliCommandHandler_System system;
    /// Command handler for all user-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final TautulliCommandHandler_Users users;
}
