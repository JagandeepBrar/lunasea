/// Dart library package to facilitate the communication to and from [Radarr](https://radarr.video)'s API:
/// A movie collection manager for Usenet and BitTorrent users.
///
/// **Only v3 and newer releases of Radarr are supported with this library.**
///
/// This library gives access to [radarr_commands], and is needed as the only entrypoint.
library radarr;

// Imports
import 'package:dio/dio.dart';
import 'package:lunasea/api/radarr/commands.dart';

/// The core class to handle all connections to Radarr.
/// Gives you easy access to all implemented command handlers, initialized and ready to call.
///
/// [RadarrAPI] handles the creation of the initial [Dio] HTTP client & command handlers.
/// You can optionally use the factory `.from()` to define your own [Dio] HTTP client.
class RadarrAPI {
  /// Internal constructor
  RadarrAPI._internal({
    required this.httpClient,
    required this.command,
    required this.credits,
    required this.fileSystem,
    required this.exclusions,
    required this.extraFile,
    required this.healthCheck,
    required this.history,
    required this.importList,
    required this.language,
    required this.manualImport,
    required this.movie,
    required this.movieFile,
    required this.movieLookup,
    required this.qualityProfile,
    required this.queue,
    required this.release,
    required this.rootFolder,
    required this.system,
    required this.tag,
  });

  /// Create a new Radarr API connection manager to connection to your instance.
  /// This default factory/constructor will create the [Dio] HTTP client for you given the parameters.
  ///
  /// Required Parameters:
  /// - `host`: String that contains the protocol (http:// or https://), the host itself, and the base URL (if applicable)
  /// - `apiKey`: The API key fetched from Radarr's web interface
  ///
  /// Optional Parameters:
  /// - `headers`: Map that contains additional headers that should be attached to all requests
  /// - `followRedirects`: If the HTTP client should follow URL redirects
  /// - `maxRedirects`: The maximum amount of redirects the client should follow (does nothing if `followRedirects` is false)
  factory RadarrAPI({
    required String host,
    required String apiKey,
    Map<String, dynamic>? headers,
    bool followRedirects = true,
    int maxRedirects = 5,
  }) {
    // Build the HTTP client
    Dio _dio = Dio(
      BaseOptions(
        baseUrl: host.endsWith('/') ? '${host}api/v3/' : '$host/api/v3/',
        queryParameters: {
          'apikey': apiKey,
        },
        headers: headers,
        followRedirects: followRedirects,
        maxRedirects: maxRedirects,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );
    return RadarrAPI._internal(
      httpClient: _dio,
      command: RadarrCommandHandlerCommand(_dio),
      credits: RadarrCommandHandlerCredits(_dio),
      fileSystem: RadarrCommandHandlerFileSystem(_dio),
      exclusions: RadarrCommandHandlerExclusions(_dio),
      extraFile: RadarrCommandHandlerExtraFile(_dio),
      healthCheck: RadarrCommandHandlerHealthCheck(_dio),
      history: RadarrCommandHandlerHistory(_dio),
      importList: RadarrCommandHandlerImportList(_dio),
      language: RadarrCommandHandlerLanguage(_dio),
      manualImport: RadarrCommandHandlerManualImport(_dio),
      movie: RadarrCommandHandlerMovie(_dio),
      movieFile: RadarrCommandHandlerMovieFile(_dio),
      movieLookup: RadarrCommandHandlerMovieLookup(_dio),
      qualityProfile: RadarrCommandHandlerQualityProfile(_dio),
      queue: RadarrCommandHandlerQueue(_dio),
      release: RadarrCommandHandlerRelease(_dio),
      rootFolder: RadarrCommandHandlerRootFolder(_dio),
      system: RadarrCommandHandlerSystem(_dio),
      tag: RadarrCommandHandlerTag(_dio),
    );
  }

  /// Create a new Radarr API connection manager to connection to your instance.
  ///
  /// This factory allows you to define your own [Dio] HTTP client.
  /// Please ensure you set [BaseOptions] to include:
  /// - `baseUrl`: The URL to your Radarr instance
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
  factory RadarrAPI.from({
    required Dio client,
  }) {
    return RadarrAPI._internal(
      httpClient: client,
      command: RadarrCommandHandlerCommand(client),
      credits: RadarrCommandHandlerCredits(client),
      fileSystem: RadarrCommandHandlerFileSystem(client),
      exclusions: RadarrCommandHandlerExclusions(client),
      extraFile: RadarrCommandHandlerExtraFile(client),
      healthCheck: RadarrCommandHandlerHealthCheck(client),
      history: RadarrCommandHandlerHistory(client),
      importList: RadarrCommandHandlerImportList(client),
      language: RadarrCommandHandlerLanguage(client),
      manualImport: RadarrCommandHandlerManualImport(client),
      movie: RadarrCommandHandlerMovie(client),
      movieFile: RadarrCommandHandlerMovieFile(client),
      movieLookup: RadarrCommandHandlerMovieLookup(client),
      qualityProfile: RadarrCommandHandlerQualityProfile(client),
      queue: RadarrCommandHandlerQueue(client),
      release: RadarrCommandHandlerRelease(client),
      rootFolder: RadarrCommandHandlerRootFolder(client),
      system: RadarrCommandHandlerSystem(client),
      tag: RadarrCommandHandlerTag(client),
    );
  }

  /// The [Dio] HTTP client built during initialization.
  ///
  /// Making changes to the [Dio] client should propogate to the command handlers, but is not recommended.
  /// The recommended way to make changes to the HTTP client is to use the `.from()` factory to build your own [Dio] HTTP client.
  final Dio httpClient;

  /// Command handler for all movie command-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final RadarrCommandHandlerCommand command;

  /// Command handler for all movie credits-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final RadarrCommandHandlerCredits credits;

  /// Command handler for all movie exclusions-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final RadarrCommandHandlerExclusions exclusions;

  /// Command handler for all movie extra files-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final RadarrCommandHandlerExtraFile extraFile;

  /// Command handler for all filesystem-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final RadarrCommandHandlerFileSystem fileSystem;

  /// Command handler for all health check-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final RadarrCommandHandlerHealthCheck healthCheck;

  /// Command handler for all history-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final RadarrCommandHandlerHistory history;

  /// Command handler for all import list-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final RadarrCommandHandlerImportList importList;

  /// Command handler for all language-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final RadarrCommandHandlerLanguage language;

  /// Command handler for all manual import-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final RadarrCommandHandlerManualImport manualImport;

  /// Command handler for all movie-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final RadarrCommandHandlerMovie movie;

  /// Command handler for all movie file-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final RadarrCommandHandlerMovieFile movieFile;

  /// Command handler for all movie lookup-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final RadarrCommandHandlerMovieLookup movieLookup;

  /// Command handler for all quality profile-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final RadarrCommandHandlerQualityProfile qualityProfile;

  /// Command handler for all queue-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final RadarrCommandHandlerQueue queue;

  /// Command handler for all release-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final RadarrCommandHandlerRelease release;

  /// Command handler for all root folder-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final RadarrCommandHandlerRootFolder rootFolder;

  /// Command handler for all system-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final RadarrCommandHandlerSystem system;

  /// Command handler for all tag-related API calls.
  ///
  /// _Check the documentation to see all API calls that fall under this category._
  final RadarrCommandHandlerTag tag;
}
