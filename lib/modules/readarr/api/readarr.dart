library readarr;

import 'package:dio/dio.dart';
import 'controllers.dart';

class Readarr {
  Readarr._internal({
    required this.httpClient,
    required this.author,
    required this.authorLookup,
    required this.book,
    required this.bookFile,
    required this.calendar,
    required this.command,
    required this.history,
    required this.importList,
    required this.profile,
    required this.queue,
    required this.release,
    required this.rootFolder,
    required this.system,
    required this.tag,
    required this.wanted,
  });

  factory Readarr({
    required String host,
    required String apiKey,
    Map<String, dynamic>? headers,
    bool followRedirects = true,
    int maxRedirects = 5,
  }) {
    Dio _dio = Dio(
      BaseOptions(
        baseUrl: host.endsWith('/') ? '${host}api/v1/' : '$host/api/v1/',
        queryParameters: {
          'apikey': apiKey,
        },
        headers: headers,
        followRedirects: followRedirects,
        maxRedirects: maxRedirects,
      ),
    );
    return Readarr._internal(
      httpClient: _dio,
      author: ReadarrControllerAuthor(_dio),
      authorLookup: ReadarrControllerAuthorLookup(_dio),
      book: ReadarrControllerBook(_dio),
      bookFile: ReadarrControllerBookFile(_dio),
      calendar: ReadarrControllerCalendar(_dio),
      command: ReadarrControllerCommand(_dio),
      history: ReadarrControllerHistory(_dio),
      importList: ReadarrControllerImportList(_dio),
      profile: ReadarrControllerProfile(_dio),
      queue: ReadarrControllerQueue(_dio),
      release: ReadarrControllerRelease(_dio),
      rootFolder: ReadarrControllerRootFolder(_dio),
      system: ReadarrControllerSystem(_dio),
      tag: ReadarrControllerTag(_dio),
      wanted: ReadarrControllerWanted(_dio),
    );
  }

  factory Readarr.from({
    required Dio client,
  }) {
    return Readarr._internal(
      httpClient: client,
      author: ReadarrControllerAuthor(client),
      authorLookup: ReadarrControllerAuthorLookup(client),
      bookFile: ReadarrControllerBookFile(client),
      book: ReadarrControllerBook(client),
      calendar: ReadarrControllerCalendar(client),
      command: ReadarrControllerCommand(client),
      history: ReadarrControllerHistory(client),
      importList: ReadarrControllerImportList(client),
      profile: ReadarrControllerProfile(client),
      queue: ReadarrControllerQueue(client),
      release: ReadarrControllerRelease(client),
      rootFolder: ReadarrControllerRootFolder(client),
      system: ReadarrControllerSystem(client),
      tag: ReadarrControllerTag(client),
      wanted: ReadarrControllerWanted(client),
    );
  }

  final Dio httpClient;

  final ReadarrControllerAuthor author;
  final ReadarrControllerAuthorLookup authorLookup;
  final ReadarrControllerBook book;
  final ReadarrControllerBookFile bookFile;
  final ReadarrControllerCalendar calendar;
  final ReadarrControllerCommand command;
  final ReadarrControllerHistory history;
  final ReadarrControllerImportList importList;
  final ReadarrControllerProfile profile;
  final ReadarrControllerQueue queue;
  final ReadarrControllerRelease release;
  final ReadarrControllerRootFolder rootFolder;
  final ReadarrControllerSystem system;
  final ReadarrControllerTag tag;
  final ReadarrControllerWanted wanted;
}
