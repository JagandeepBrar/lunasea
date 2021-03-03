import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrWebhooks extends LunaWebhooks {
    @override
    Future<void> handle(Map<dynamic, dynamic> data) async {
        _EventType event = _EventType.GRAB.fromKey(data['event']);
        if(event == null) LunaLogger().warning(
            'RadarrWebhooks',
            'handle',
            'Unknown event type: ${data['event'] ?? 'null'}',
        );
        event?.execute(data);
    }
}

enum _EventType {
    DOWNLOAD,
    GRAB,
    HEALTH,
    RENAME,
    TEST,
}

extension _EventTypeExtension on _EventType {
    _EventType fromKey(String key) {
        switch(key) {
            case 'Download': return _EventType.DOWNLOAD;
            case 'Grab': return _EventType.GRAB;
            case 'Health': return _EventType.HEALTH;
            case 'Rename': return _EventType.RENAME;
            case 'Test': return _EventType.TEST;
        }
        return null;
    }

    Future<void> execute(Map<dynamic, dynamic> data) async {
        switch(this) {
            case _EventType.GRAB: return _grabEvent(data);
            case _EventType.DOWNLOAD: return _downloadEvent(data);
            case _EventType.HEALTH: return _healthEvent(data);
            case _EventType.RENAME: return _renameEvent(data);
            case _EventType.TEST: return _testEvent(data);
        }
    }

    Future<void> _downloadEvent(Map<dynamic, dynamic> data) async {
        int movieId = int.tryParse(data['id']);
        if(movieId != null) return RadarrMoviesDetailsRouter().navigateTo(
            LunaState.navigatorKey.currentContext,
            movieId: movieId,
        );
    }

    Future<void> _grabEvent(Map<dynamic, dynamic> data) async {
        int movieId = int.tryParse(data['id']);
        if(movieId != null) return RadarrMoviesDetailsRouter().navigateTo(
            LunaState.navigatorKey.currentContext,
            movieId: movieId,
        );
    }

    Future<void> _healthEvent(Map<dynamic, dynamic> data) async {
        return RadarrSystemStatusRouter().navigateTo(LunaState.navigatorKey.currentContext);
    }

    Future<void> _renameEvent(Map<dynamic, dynamic> data) async {
        int movieId = int.tryParse(data['id']);
        if(movieId != null) return RadarrMoviesDetailsRouter().navigateTo(
            LunaState.navigatorKey.currentContext,
            movieId: movieId,
        );
    }

    Future<void> _testEvent(Map<dynamic, dynamic> data) async {
        return LunaModule.RADARR.launch();
    }
}
