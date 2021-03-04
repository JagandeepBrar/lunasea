import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrWebhooks extends LunaWebhooks {
    @override
    Future<void> handle(Map<dynamic, dynamic> data) async {
        _EventType event = _EventType.GRAB.fromKey(data['event']);
        if(event == null) LunaLogger().warning(
            'SonarrWebhooks',
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
    _EventType fromKey(String key) {
        switch(key) {
            case 'Download': return _EventType.DOWNLOAD;
            case 'EpisodeFileDelete': return _EventType.EPISODE_FILE_DELETE;
            case 'Grab': return _EventType.GRAB;
            case 'Health': return _EventType.HEALTH;
            case 'Rename': return _EventType.RENAME;
            case 'SeriesDelete': return _EventType.SERIES_DELETE;
            case 'Test': return _EventType.TEST;
        }
        return null;
    }

    Future<void> execute(Map<dynamic, dynamic> data) async {
        switch(this) {
            case _EventType.DOWNLOAD: return _downloadEvent(data);
            case _EventType.EPISODE_FILE_DELETE: return _episodeFileDeleteEvent(data);
            case _EventType.GRAB: return _grabEvent(data);
            case _EventType.HEALTH: return _healthEvent(data);
            case _EventType.RENAME: return _renameEvent(data);
            case _EventType.SERIES_DELETE: return _seriesDeleteEvent(data);
            case _EventType.TEST: return _testEvent(data);
        }
    }

    Future<void> _downloadEvent(Map<dynamic, dynamic> data) async {
        int seriesId = int.tryParse(data['seriesId']);
        int seasonNumber = int.tryParse(data['seasonNumber']);
        if(seriesId != null && seasonNumber != null) SonarrSeasonDetailsRouter().navigateTo(
            LunaState.navigatorKey.currentContext,
            seriesId: seriesId,
            seasonNumber: seasonNumber,
        );
    }

    Future<void> _episodeFileDeleteEvent(Map<dynamic, dynamic> data) async {
        int seriesId = int.tryParse(data['seriesId']);
        int seasonNumber = int.tryParse(data['seasonNumber']);
        if(seriesId != null && seasonNumber != null) SonarrSeasonDetailsRouter().navigateTo(
            LunaState.navigatorKey.currentContext,
            seriesId: seriesId,
            seasonNumber: seasonNumber,
        );
    }

    Future<void> _grabEvent(Map<dynamic, dynamic> data) async {
        int seriesId = int.tryParse(data['seriesId']);
        int seasonNumber = int.tryParse(data['seasonNumber']);
        if(seriesId != null && seasonNumber != null) SonarrSeasonDetailsRouter().navigateTo(
            LunaState.navigatorKey.currentContext,
            seriesId: seriesId,
            seasonNumber: seasonNumber,
        );
    }

    Future<void> _healthEvent(Map<dynamic, dynamic> data) async {
        return LunaModule.SONARR.launch();
    }

    Future<void> _renameEvent(Map<dynamic, dynamic> data) async {
        int seriesId = int.tryParse(data['seriesId']);
        if(seriesId != null) SonarrSeriesDetailsRouter().navigateTo(
            LunaState.navigatorKey.currentContext,
            seriesId: seriesId,
        );
    }

    Future<void> _seriesDeleteEvent(Map<dynamic, dynamic> data) async {
        return LunaModule.SONARR.launch();
    }

    Future<void> _testEvent(Map<dynamic, dynamic> data) async {
        return LunaModule.SONARR.launch();
    }
}
