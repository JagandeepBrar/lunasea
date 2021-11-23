library sonarr;

import 'package:dio/dio.dart';
import 'commands.dart';
export 'commands.dart';
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
      calendar: SonarrCommandHandler_Calendar(_dio),
      command: SonarrCommandHandler_Command(_dio),
      episode: SonarrCommandHandler_Episode(_dio),
      episodeFile: SonarrCommandHandler_EpisodeFile(_dio),
      history: SonarrCommandHandler_History(_dio),
      importList: SonarrCommandHandler_ImportList(_dio),
      profile: SonarrCommandHandler_Profile(_dio),
      queue: SonarrCommandHandler_Queue(_dio),
      release: SonarrCommandHandler_Release(_dio),
      rootFolder: SonarrCommandHandler_RootFolder(_dio),
      series: SonarrCommandHandler_Series(_dio),
      seriesLookup: SonarrCommandHandler_SeriesLookup(_dio),
      system: SonarrCommandHandler_System(_dio),
      tag: SonarrCommandHandler_Tag(_dio),
      wanted: SonarrCommandHandler_Wanted(_dio),
    );
  }

  factory Sonarr.from({
    required Dio client,
  }) {
    return Sonarr._internal(
      httpClient: client,
      calendar: SonarrCommandHandler_Calendar(client),
      command: SonarrCommandHandler_Command(client),
      episode: SonarrCommandHandler_Episode(client),
      episodeFile: SonarrCommandHandler_EpisodeFile(client),
      history: SonarrCommandHandler_History(client),
      importList: SonarrCommandHandler_ImportList(client),
      profile: SonarrCommandHandler_Profile(client),
      queue: SonarrCommandHandler_Queue(client),
      release: SonarrCommandHandler_Release(client),
      rootFolder: SonarrCommandHandler_RootFolder(client),
      series: SonarrCommandHandler_Series(client),
      seriesLookup: SonarrCommandHandler_SeriesLookup(client),
      system: SonarrCommandHandler_System(client),
      tag: SonarrCommandHandler_Tag(client),
      wanted: SonarrCommandHandler_Wanted(client),
    );
  }

  final Dio httpClient;

  final SonarrCommandHandler_Calendar calendar;
  final SonarrCommandHandler_Command command;
  final SonarrCommandHandler_Episode episode;
  final SonarrCommandHandler_EpisodeFile episodeFile;
  final SonarrCommandHandler_History history;
  final SonarrCommandHandler_ImportList importList;
  final SonarrCommandHandler_Profile profile;
  final SonarrCommandHandler_Queue queue;
  final SonarrCommandHandler_Release release;
  final SonarrCommandHandler_RootFolder rootFolder;
  final SonarrCommandHandler_Series series;
  final SonarrCommandHandler_SeriesLookup seriesLookup;
  final SonarrCommandHandler_System system;
  final SonarrCommandHandler_Tag tag;
  final SonarrCommandHandler_Wanted wanted;
}
