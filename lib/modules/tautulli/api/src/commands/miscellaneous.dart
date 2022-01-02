part of tautulli_commands;

/// Facilitates, encapsulates, and manages individual calls for any miscellaneous calls within Tautulli.
///
/// [TautulliCommandHandlerMiscellaneous] internally handles routing the HTTP client to the API calls.
class TautulliCommandHandlerMiscellaneous {
  final Dio _client;

  /// Create a miscellaneous command handler using an initialized [Dio] client.
  TautulliCommandHandlerMiscellaneous(this._client);

  /// Handler for [arnold](https://github.com/Tautulli/Tautulli/blob/master/API.md#arnold).
  ///
  /// Get to the chopper!
  Future<String?> arnold() async => _commandArnold(_client);

  /// Handler for [docs](https://github.com/Tautulli/Tautulli/blob/master/API.md#docs).
  ///
  /// Return the API docs as a dict (map) where commands are keys, docstring are value.
  Future<Map<String, dynamic>?> docs() async => _commandDocs(_client);

  /// Handler for [docs_md](https://github.com/Tautulli/Tautulli/blob/master/API.md#docs_md).
  ///
  /// Return the API docs formatted with markdown.
  ///
  /// Returns a Uint8List which contains the markdown file's binary data.
  Future<Uint8List?> docsMd() async => _commandDocsMd(_client);

  /// Handler for [download_config](https://github.com/Tautulli/Tautulli/blob/master/API.md#download_config).
  ///
  /// Download the Tautulli configuration file.
  ///
  /// Returns a Uint8List which contains the configuration file's binary data.
  Future<Uint8List?> downloadConfig() async => _commandDownloadConfig(_client);

  /// Handler for [download_database](https://github.com/Tautulli/Tautulli/blob/master/API.md#download_database).
  ///
  /// Download the Tautulli database file.
  ///
  /// Returns a Uint8List which contains the database file's binary data.
  Future<Uint8List?> downloadDatabase() async =>
      _commandDownloadDatabase(_client);

  /// Handler for [download_log](https://github.com/Tautulli/Tautulli/blob/master/API.md#download_log).
  ///
  /// Download the Tautulli log file.
  ///
  /// Returns a Uint8List which contains the log file's binary data.
  Future<Uint8List?> downloadLog() async => _commandDownloadLog(_client);

  /// Handler for [download_plex_log](https://github.com/Tautulli/Tautulli/blob/master/API.md#download_plex_log).
  ///
  /// Download the Plex log file.
  ///
  /// Returns a Uint8List which contains the plex log file's binary data.
  Future<Uint8List?> downloadPlexLog() async =>
      _commandDownloadPlexLog(_client);

  /// Handler for [get_date_formats](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_date_formats).
  ///
  /// Get the date and time formats used by Tautulli.
  Future<TautulliDateFormat> getDateFormats() async =>
      _commandGetDateFormats(_client);

  /// Handler for [get_geoip_lookup](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_geoip_lookup).
  ///
  /// Get the geolocation info for an IP address.
  ///
  /// Required Parameters:
  /// - `ipAddress`: The IP address to lookup
  Future<TautulliGeolocationInfo> getGeoIPLookup({
    required String ipAddress,
  }) async =>
      _commandGetGeoIPLookup(_client, ipAddress: ipAddress);

  /// Handler for [get_logs](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_logs).
  ///
  /// Get the Tautulli logs.
  ///
  /// Optional Parameters:
  /// - `search`: A string to search for
  /// - `orderColumn`: The column order key for sorting the log records
  /// - `orderDirection`: The direction to sort the log records
  /// - `regex`: A regex string to search for
  /// - `start`: Row number to start from
  /// - `end`: Row number to end at
  Future<List<TautulliLog>> getLogs({
    String? search,
    TautulliLogsOrderColumn? orderColumn,
    TautulliOrderDirection? orderDirection,
    String? regex,
    int? start,
    int? end,
  }) async =>
      _commandGetLogs(
        _client,
        search: search,
        orderColumn: orderColumn,
        orderDirection: orderDirection,
        regex: regex,
        start: start,
        end: end,
      );

  /// Handler for [get_plex_log](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_plex_log).
  ///
  /// Get the Plex Media Server/Plex Media Scanner logs.
  ///
  /// Optional Parameters:
  /// - `window`: The number of tail lines to return
  /// - `logType`: The type of logs to fetch
  Future<List<TautulliPlexLog>> getPlexLog({
    int? window,
    TautulliPlexLogType? logType,
  }) async =>
      _commandGetPlexLog(_client, window: window, logType: logType);

  /// Handler for [get_server_friendly_name](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_server_friendly_name).
  ///
  /// Get the name of the Plex Media Server.
  Future<String?> getServerFriendlyName() async =>
      _commandGetServerFriendlyName(_client);

  /// Handler for [get_server_id](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_server_id).
  ///
  /// Get the Plex Media Server identifier.
  ///
  /// Required Parameters:
  /// - `hostname`: IP address or domain of the Plex Media Server
  /// - `port`: Port that Plex Media Server is remotely accessible at
  ///
  /// Optional Parameters:
  /// - `ssl`: Connect via a secure connection?
  /// - `remote`: Is the server remotely hosted?
  Future<String?> getServerID({
    required String hostname,
    required int port,
    bool? ssl,
    bool? remote,
  }) async =>
      _commandGetServerID(_client,
          hostname: hostname, port: port, ssl: ssl, remote: remote);

  /// Handler for [get_server_identity](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_server_identity).
  ///
  /// Get info about the local server.
  Future<TautulliServerIdentity> getServerIdentity() async =>
      _commandGetServerIdentity(_client);

  /// Handler for [get_server_list](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_server_list).
  ///
  /// Get all your servers that are published to Plex.tv.
  Future<List<TautulliServer>> getServerList() async =>
      _commandGetServerList(_client);

  /// Handler for [get_server_pref](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_server_pref).
  ///
  /// Get a specified Plex Media Server instance preference.
  ///
  /// Required Parameters:
  /// - `preference`: Name of preference
  Future<dynamic> getServerPref({
    required String preference,
  }) async =>
      _commandGetServerPref(_client, preference: preference);

  /// Handler for [get_servers_info](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_servers_info).
  ///
  /// Get info about the Plex Media Server(s).
  Future<List<TautulliServerInfo>> getServersInfo() async =>
      _commandGetServersInfo(_client);

  /// Handler for [get_whois_lookup](https://github.com/Tautulli/Tautulli/blob/master/API.md#get_whois_lookup).
  ///
  /// Get the connection info for an IP address.
  ///
  /// Required Parameters:
  /// - `ipAddress`: The IP address to lookup.
  Future<TautulliWHOISInfo> getWHOISLookup({
    required String ipAddress,
  }) async =>
      _commandGetWHOISLookup(_client, ipAddress: ipAddress);

  /// Handler for [pms_image_proxy](https://github.com/Tautulli/Tautulli/blob/master/API.md#pms_image_proxy).
  ///
  /// Gets an image from the PMS and saves it to the image cache directory. Returns a Uint8List of the image buffer.
  ///
  /// Required Parameters:
  /// - `image`: Path to the image to download from Plex, **OR**
  /// - `ratingKey`: Rating key of the content.
  ///
  /// Optional Parameters:
  /// - `width`: Width to scale the image to
  /// - `height`: Height to scale the image to
  /// - `opacity`: Set the opacity of the image to (0 to 100)
  /// - `background`: Set the background color (HEX colors, e.g. 282828)
  /// - `blur`: How much to the blur the image
  /// - `imageFormat`: The format to download the image as (jpg, png, etc.)
  /// - `fallbackImage`: A fallback image to return if there is no image
  /// - `refresh`: Whether to refresh the image cache first
  Future<Uint8List?> pmsImageProxy({
    String? image,
    int? ratingKey,
    int? width,
    int? height,
    int? opacity,
    String? background,
    int? blur,
    String? imageFormat,
    TautulliFallbackImage? fallbackImage,
    bool? refresh,
  }) async =>
      _commandPMSImageProxy(
        _client,
        image: image,
        ratingKey: ratingKey,
        width: width,
        height: height,
        opacity: opacity,
        background: background,
        blur: blur,
        imageFormat: imageFormat,
        fallbackImage: fallbackImage,
        refresh: refresh,
      );

  /// Handler for [sql](https://github.com/Tautulli/Tautulli/blob/master/API.md#sql).
  ///
  /// Query the Tautulli database with raw SQL.
  ///
  /// Automatically makes a backup of the database if the latest backup is older than 24 hours.
  /// `api_sql` must be manually enabled in the config file while Tautulli is shut down.
  ///
  /// Required Parameters:
  /// - `query`: The SQL query to run.
  Future<void> sql({
    required String query,
  }) async =>
      _commandSql(_client, query: query);
}
