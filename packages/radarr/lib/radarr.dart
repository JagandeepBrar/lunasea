/// Dart library package to facilitate the communication to and from [Radarr](https://radarr.video)'s API:
/// A movie collection manager for Usenet and BitTorrent users.
/// 
/// **Only v3 and newer releases of Radarr are supported with this library.**
/// 
/// This library gives access to [radarr_commands], and is needed as the only entrypoint.
library radarr;

// Imports
import 'package:dio/dio.dart';
import 'commands.dart';

// Exports
export 'commands.dart';
export 'models.dart';
export 'types.dart';
export 'utilities.dart';

/// The core class to handle all connections to Radarr.
/// Gives you easy access to all implemented command handlers, initialized and ready to call.
/// 
/// [Radarr] handles the creation of the initial [Dio] HTTP client & command handlers.
/// You can optionally use the factory `.from()` to define your own [Dio] HTTP client.
class Radarr {
    /// Internal constructor
    Radarr._internal({
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
    factory Radarr({
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
                    ? '${host}api/v3/'
                    : '$host/api/v3/',
                queryParameters: {
                    'apikey': apiKey,
                },
                headers: headers,
                followRedirects: followRedirects,
                maxRedirects: maxRedirects,
            ),
        );
        return Radarr._internal(
            httpClient: _dio,
            command: RadarrCommandHandler_Command(_dio),
            credits: RadarrCommandHandler_Credits(_dio),
            fileSystem: RadarrCommandHandler_FileSystem(_dio),
            exclusions: RadarrCommandHandler_Exclusions(_dio),
            extraFile: RadarrCommandHandler_ExtraFile(_dio),
            healthCheck: RadarrCommandHandler_HealthCheck(_dio),
            history: RadarrCommandHandler_History(_dio),
            importList: RadarrCommandHandler_ImportList(_dio),
            language: RadarrCommandHandler_Language(_dio),
            manualImport: RadarrCommandHandler_ManualImport(_dio),
            movie: RadarrCommandHandler_Movie(_dio),
            movieFile: RadarrCommandHandler_MovieFile(_dio),
            movieLookup: RadarrCommandHandler_MovieLookup(_dio),
            qualityProfile: RadarrCommandHandler_QualityProfile(_dio),
            queue: RadarrCommandHandler_Queue(_dio),
            release: RadarrCommandHandler_Release(_dio),
            rootFolder: RadarrCommandHandler_RootFolder(_dio),
            system: RadarrCommandHandler_System(_dio),
            tag: RadarrCommandHandler_Tag(_dio),
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
    factory Radarr.from({
        required Dio client,
    }) {
        return Radarr._internal(
            httpClient: client,
            command: RadarrCommandHandler_Command(client),
            credits: RadarrCommandHandler_Credits(client),
            fileSystem: RadarrCommandHandler_FileSystem(client),
            exclusions: RadarrCommandHandler_Exclusions(client),
            extraFile: RadarrCommandHandler_ExtraFile(client),
            healthCheck: RadarrCommandHandler_HealthCheck(client),
            history: RadarrCommandHandler_History(client),
            importList: RadarrCommandHandler_ImportList(client),
            language: RadarrCommandHandler_Language(client),
            manualImport: RadarrCommandHandler_ManualImport(client),
            movie: RadarrCommandHandler_Movie(client),
            movieFile: RadarrCommandHandler_MovieFile(client),
            movieLookup: RadarrCommandHandler_MovieLookup(client),
            qualityProfile: RadarrCommandHandler_QualityProfile(client),
            queue: RadarrCommandHandler_Queue(client),
            release: RadarrCommandHandler_Release(client),
            rootFolder: RadarrCommandHandler_RootFolder(client),
            system: RadarrCommandHandler_System(client),
            tag: RadarrCommandHandler_Tag(client),
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
    final RadarrCommandHandler_Command command;

    /// Command handler for all movie credits-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final RadarrCommandHandler_Credits credits;

    /// Command handler for all movie exclusions-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final RadarrCommandHandler_Exclusions exclusions;

    /// Command handler for all movie extra files-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final RadarrCommandHandler_ExtraFile extraFile;

    /// Command handler for all filesystem-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final RadarrCommandHandler_FileSystem fileSystem;

    /// Command handler for all health check-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final RadarrCommandHandler_HealthCheck healthCheck;

    /// Command handler for all history-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final RadarrCommandHandler_History history;

    /// Command handler for all import list-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final RadarrCommandHandler_ImportList importList;

    /// Command handler for all language-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final RadarrCommandHandler_Language language;

    /// Command handler for all manual import-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final RadarrCommandHandler_ManualImport manualImport;

    /// Command handler for all movie-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final RadarrCommandHandler_Movie movie;

    /// Command handler for all movie file-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final RadarrCommandHandler_MovieFile movieFile;

    /// Command handler for all movie lookup-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final RadarrCommandHandler_MovieLookup movieLookup;

    /// Command handler for all quality profile-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final RadarrCommandHandler_QualityProfile qualityProfile;

    /// Command handler for all queue-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final RadarrCommandHandler_Queue queue;

    /// Command handler for all release-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final RadarrCommandHandler_Release release;

    /// Command handler for all root folder-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final RadarrCommandHandler_RootFolder rootFolder;

    /// Command handler for all system-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final RadarrCommandHandler_System system;

    /// Command handler for all tag-related API calls.
    /// 
    /// _Check the documentation to see all API calls that fall under this category._
    final RadarrCommandHandler_Tag tag;
}
