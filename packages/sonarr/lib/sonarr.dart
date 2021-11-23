library sonarr;

import 'package:dio/dio.dart';
import 'controllers.dart';
export 'controllers.dart';
export 'models.dart';
export 'types.dart';
export 'utilities.dart';

class Sonarr {
  Sonarr._internal({
    required this.httpClient,
    required this.calendar,
    required this.command,
    required this.episode,
    required this.episodeFile,
    required this.history,
    required this.importList,
    required this.profile,
    required this.queue,
    required this.release,
    required this.rootFolder,
    required this.series,
    required this.seriesLookup,
    required this.system,
    required this.tag,
    required this.wanted,
  });

  factory Sonarr({
    required String host,
    required String apiKey,
    Map<String, dynamic>? headers,
    bool followRedirects = true,
    int maxRedirects = 5,
  }) {
    Dio _dio = Dio(
      BaseOptions(
        baseUrl: host.endsWith('/') ? '${host}api/v3/' : '$host/api/v3/',
        queryParameters: {
          'apikey': apiKey,
        },
        headers: headers,
        followRedirects: followRedirects,
        maxRedirects: maxRedirects,
      ),
    );
    return Sonarr._internal(
      httpClient: _dio,
      calendar: SonarrController_Calendar(_dio),
      command: SonarrController_Command(_dio),
      episode: SonarrController_Episode(_dio),
      episodeFile: SonarrController_EpisodeFile(_dio),
      history: SonarrController_History(_dio),
      importList: SonarrController_ImportList(_dio),
      profile: SonarrController_Profile(_dio),
      queue: SonarrController_Queue(_dio),
      release: SonarrController_Release(_dio),
      rootFolder: SonarrController_RootFolder(_dio),
      series: SonarrController_Series(_dio),
      seriesLookup: SonarrController_SeriesLookup(_dio),
      system: SonarrController_System(_dio),
      tag: SonarrController_Tag(_dio),
      wanted: SonarrController_Wanted(_dio),
    );
  }

  factory Sonarr.from({
    required Dio client,
  }) {
    return Sonarr._internal(
      httpClient: client,
      calendar: SonarrController_Calendar(client),
      command: SonarrController_Command(client),
      episode: SonarrController_Episode(client),
      episodeFile: SonarrController_EpisodeFile(client),
      history: SonarrController_History(client),
      importList: SonarrController_ImportList(client),
      profile: SonarrController_Profile(client),
      queue: SonarrController_Queue(client),
      release: SonarrController_Release(client),
      rootFolder: SonarrController_RootFolder(client),
      series: SonarrController_Series(client),
      seriesLookup: SonarrController_SeriesLookup(client),
      system: SonarrController_System(client),
      tag: SonarrController_Tag(client),
      wanted: SonarrController_Wanted(client),
    );
  }

  final Dio httpClient;

  final SonarrController_Calendar calendar;
  final SonarrController_Command command;
  final SonarrController_Episode episode;
  final SonarrController_EpisodeFile episodeFile;
  final SonarrController_History history;
  final SonarrController_ImportList importList;
  final SonarrController_Profile profile;
  final SonarrController_Queue queue;
  final SonarrController_Release release;
  final SonarrController_RootFolder rootFolder;
  final SonarrController_Series series;
  final SonarrController_SeriesLookup seriesLookup;
  final SonarrController_System system;
  final SonarrController_Tag tag;
  final SonarrController_Wanted wanted;
}
