import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrWebhooks extends LunaWebhooks {
  @override
  Future<void> handle(Map<dynamic, dynamic> data) async {
    _EventType? event = _EventType.GRAB.fromKey(data['event']);
    if (event == null)
      LunaLogger().warning(
        'ReadarrWebhooks',
        'handle',
        'Unknown event type: ${data['event'] ?? 'null'}',
      );
    event?.execute(data);
  }
}

enum _EventType {
  DOWNLOAD,
  EPISODE_FILE_DELETE,
  GRAB,
  HEALTH,
  RENAME,
  SERIES_DELETE,
  TEST,
}

extension _EventTypeExtension on _EventType {
  _EventType? fromKey(String? key) {
    switch (key) {
      case 'Download':
        return _EventType.DOWNLOAD;
      case 'EpisodeFileDelete':
        return _EventType.EPISODE_FILE_DELETE;
      case 'Grab':
        return _EventType.GRAB;
      case 'Health':
        return _EventType.HEALTH;
      case 'Rename':
        return _EventType.RENAME;
      case 'SeriesDelete':
        return _EventType.SERIES_DELETE;
      case 'Test':
        return _EventType.TEST;
    }
    return null;
  }

  Future<void> execute(Map<dynamic, dynamic> data) async {
    switch (this) {
      case _EventType.DOWNLOAD:
        return _downloadEvent(data);
      case _EventType.EPISODE_FILE_DELETE:
        return _episodeFileDeleteEvent(data);
      case _EventType.GRAB:
        return _grabEvent(data);
      case _EventType.HEALTH:
        return _healthEvent(data);
      case _EventType.RENAME:
        return _renameEvent(data);
      case _EventType.SERIES_DELETE:
        return _seriesDeleteEvent(data);
      case _EventType.TEST:
        return _testEvent(data);
    }
  }

  Future<void> _downloadEvent(Map<dynamic, dynamic> data) async =>
      _goToSeasonDetails(
          int.tryParse(data['authorId']), int.tryParse(data['seasonNumber']));
  Future<void> _episodeFileDeleteEvent(Map<dynamic, dynamic> data) async =>
      _goToSeasonDetails(
          int.tryParse(data['authorId']), int.tryParse(data['seasonNumber']));
  Future<void> _grabEvent(Map<dynamic, dynamic> data) async =>
      ReadarrQueueRouter().navigateTo(LunaState.navigatorKey.currentContext!);
  Future<void> _healthEvent(Map<dynamic, dynamic> data) async =>
      LunaModule.READARR.launch();
  Future<void> _renameEvent(Map<dynamic, dynamic> data) async =>
      _goToSeriesDetails(int.tryParse(data['authorId']));
  Future<void> _seriesDeleteEvent(Map<dynamic, dynamic> data) async =>
      LunaModule.READARR.launch();
  Future<void> _testEvent(Map<dynamic, dynamic> data) async =>
      LunaModule.READARR.launch();

  Future<void> _goToSeriesDetails(int? authorId) async {
    if (authorId != null) {
      return ReadarrAuthorDetailsRouter().navigateTo(
        LunaState.navigatorKey.currentContext!,
        authorId,
      );
    }
    return LunaModule.READARR.launch();
  }

  Future<void> _goToSeasonDetails(int? bookId, int? seasonNumber) async {
    if (bookId != null) {
      return ReadarrBookDetailsRouter().navigateTo(
        LunaState.navigatorKey.currentContext!,
        bookId,
      );
    }
    return LunaModule.READARR.launch();
  }
}
