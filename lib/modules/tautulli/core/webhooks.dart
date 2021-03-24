import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliWebhooks extends LunaWebhooks {
    @override
    Future<void> handle(Map<dynamic, dynamic> data) async {
        _EventType event = _EventType.PLAYBACK_PAUSE.fromKey(data['event']);
        if(event == null) LunaLogger().warning(
            'TautulliWebhooks',
            'handle',
            'Unknown event type: ${data['event'] ?? 'null'}',
        );
        event?.execute(data);
    }
}

enum _EventType {
    BUFFFER_WARNING,
    PLAYBACK_ERROR,
    PLAYBACK_PAUSE,
    PLAYBACK_RESUME,
    PLAYBACK_START,
    PLAYBACK_STOP,
    PLEX_REMOTE_ACCESS_BACK_UP,
    PLEX_REMOTE_ACCESS_DOWN,
    PLEX_SERVER_BACK_UP,
    PLEX_SERVER_DOWN,
    PLEX_UPDATE_AVAILABLE,
    RECENTLY_ADDED,
    TAUTULLI_DATABASE_CORRUPTION,
    TAUTULLI_UPDATE_AVAILABLE,
    TRANSCODE_DECISION_CHANGE,
    USER_CONCURRENT_STREAMS,
    USER_NEW_DEVICE,
    WATCHED,
}

extension _EventTypeExtension on _EventType {
    _EventType fromKey(String key) {
        switch(key) {
            case 'BufferWarning': return _EventType.BUFFFER_WARNING;
            case 'PlaybackError': return _EventType.PLAYBACK_ERROR;
            case 'PlaybackPause': return _EventType.PLAYBACK_PAUSE;
            case 'PlaybackResume': return _EventType.PLAYBACK_RESUME;
            case 'PlaybackStart': return _EventType.PLAYBACK_START;
            case 'PlaybackStop': return _EventType.PLAYBACK_STOP;
            case 'PlexRemoteAccessBackUp': return _EventType.PLEX_REMOTE_ACCESS_BACK_UP;
            case 'PlexRemoteAccessDown': return _EventType.PLEX_REMOTE_ACCESS_DOWN;
            case 'PlexServerBackUp': return _EventType.PLEX_SERVER_BACK_UP;
            case 'PlexServerDown': return _EventType.PLEX_SERVER_DOWN;
            case 'PlexUpdateAvailable': return _EventType.PLEX_UPDATE_AVAILABLE;
            case 'RecentlyAdded': return _EventType.RECENTLY_ADDED;
            case 'TautulliDatabaseCorruption': return _EventType.TAUTULLI_DATABASE_CORRUPTION;
            case 'TautulliUpdateAvailable': return _EventType.TAUTULLI_UPDATE_AVAILABLE;
            case 'TranscodeDecisionChange': return _EventType.TRANSCODE_DECISION_CHANGE;
            case 'UserConcurrentStreams': return _EventType.USER_CONCURRENT_STREAMS;
            case 'UserNewDevice': return _EventType.USER_NEW_DEVICE;
            case 'Watched': return _EventType.WATCHED;
        }
        return null;
    }

    Future<void> execute(Map<dynamic, dynamic> data) async {
        switch(this) {
            case _EventType.BUFFFER_WARNING: return _bufferWarning(data);
            case _EventType.PLAYBACK_ERROR: return _playbackErrorEvent(data);
            case _EventType.PLAYBACK_PAUSE: return _playbackPauseEvent(data);
            case _EventType.PLAYBACK_RESUME: return _playbackResumeEvent(data);
            case _EventType.PLAYBACK_START: return _playbackStartEvent(data);
            case _EventType.PLAYBACK_STOP: return _playbackStopEvent(data);
            case _EventType.PLEX_REMOTE_ACCESS_BACK_UP: return _plexRemoteAccessBackUp(data);
            case _EventType.PLEX_REMOTE_ACCESS_DOWN: return _plexRemoteAccessDown(data);
            case _EventType.PLEX_SERVER_BACK_UP: return _plexServerBackUp(data);
            case _EventType.PLEX_SERVER_DOWN: return _plexServerDown(data);
            case _EventType.PLEX_UPDATE_AVAILABLE: return _plexUpdateAvailable(data);
            case _EventType.RECENTLY_ADDED: return _recentlyAdded(data);
            case _EventType.TAUTULLI_DATABASE_CORRUPTION: return _tautulliDatabaseCorruption(data);
            case _EventType.TAUTULLI_UPDATE_AVAILABLE: return _tautulliUpdateAvailable(data);
            case _EventType.TRANSCODE_DECISION_CHANGE: return _transcodeDecisionChangeEvent(data);
            case _EventType.USER_CONCURRENT_STREAMS: return _userConcurrentStreams(data);
            case _EventType.USER_NEW_DEVICE: return _userNewDevice(data);
            case _EventType.WATCHED: return _watchedEvent(data);
        }
    }

    Future<void> _bufferWarning(Map<dynamic, dynamic> data) async => _goToActivityDetails(data['session_id']);
    Future<void> _playbackErrorEvent(Map<dynamic, dynamic> data) async => _goToUserDetails(int.tryParse(data['user_id']));
    Future<void> _playbackPauseEvent(Map<dynamic, dynamic> data) async => _goToActivityDetails(data['session_id']);
    Future<void> _playbackResumeEvent(Map<dynamic, dynamic> data) async => _goToActivityDetails(data['session_id']);
    Future<void> _playbackStartEvent(Map<dynamic, dynamic> data) async => _goToActivityDetails(data['session_id']);
    Future<void> _playbackStopEvent(Map<dynamic, dynamic> data) async => _goToUserDetails(int.tryParse(data['user_id']));
    Future<void> _plexRemoteAccessBackUp(Map<dynamic, dynamic> data) async => TautulliLogsRouter().navigateTo(LunaState.navigatorKey.currentContext);
    Future<void> _plexRemoteAccessDown(Map<dynamic, dynamic> data) async => TautulliLogsRouter().navigateTo(LunaState.navigatorKey.currentContext);
    Future<void> _plexServerBackUp(Map<dynamic, dynamic> data) async => TautulliLogsRouter().navigateTo(LunaState.navigatorKey.currentContext);
    Future<void> _plexServerDown(Map<dynamic, dynamic> data) async => TautulliLogsRouter().navigateTo(LunaState.navigatorKey.currentContext);
    Future<void> _plexUpdateAvailable(Map<dynamic, dynamic> data) async => TautulliCheckForUpdatesRouter().navigateTo(LunaState.navigatorKey.currentContext);
    Future<void> _recentlyAdded(Map<dynamic, dynamic> data) async => TautulliRecentlyAddedRouter().navigateTo(LunaState.navigatorKey.currentContext);
    Future<void> _tautulliDatabaseCorruption(Map<dynamic, dynamic> data) async => TautulliLogsRouter().navigateTo(LunaState.navigatorKey.currentContext);
    Future<void> _tautulliUpdateAvailable(Map<dynamic, dynamic> data) async => TautulliCheckForUpdatesRouter().navigateTo(LunaState.navigatorKey.currentContext);
    Future<void> _transcodeDecisionChangeEvent(Map<dynamic, dynamic> data) async => _goToActivityDetails(data['session_id']);
    Future<void> _userConcurrentStreams(Map<dynamic, dynamic> data) async => _goToUserDetails(int.tryParse(data['user_id']));
    Future<void> _userNewDevice(Map<dynamic, dynamic> data) async => _goToUserDetails(int.tryParse(data['user_id']));
    Future<void> _watchedEvent(Map<dynamic, dynamic> data) async => _goToUserDetails(int.tryParse(data['user_id']));

    Future<void> _goToHome() async {
        return LunaModule.TAUTULLI.launch();
    }

    Future<void> _goToUserDetails(int userId) async {
        if(userId != null) return TautulliUserDetailsRouter().navigateTo(
            LunaState.navigatorKey.currentContext,
            userId: userId,
        );
        return _goToHome();
    }

    Future<void> _goToActivityDetails(String sessionId) async {
        if(sessionId != null && sessionId.isNotEmpty) return TautulliActivityDetailsRouter().navigateTo(
            LunaState.navigatorKey.currentContext,
            sessionId: sessionId,
        );
        return _goToHome();
    }
}
