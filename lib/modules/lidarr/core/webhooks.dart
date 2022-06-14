import 'package:lunasea/core.dart';
import 'package:lunasea/system/webhooks.dart';

class LidarrWebhooks extends LunaWebhooks {
  @override
  Future<void> handle(Map<dynamic, dynamic> data) async {
    _EventType? event = _EventType.GRAB.fromKey(data['event']);
    if (event == null)
      LunaLogger().warning(
        'Unknown event type: ${data['event'] ?? 'null'}',
      );
    event?.execute(data);
  }
}

enum _EventType {
  DOWNLOAD,
  GRAB,
  RENAME,
  RETAG,
  TEST,
}

extension _EventTypeExtension on _EventType {
  _EventType? fromKey(String key) {
    switch (key) {
      case 'Download':
        return _EventType.DOWNLOAD;
      case 'Grab':
        return _EventType.GRAB;
      case 'Rename':
        return _EventType.RENAME;
      case 'Retag':
        return _EventType.RETAG;
      case 'Test':
        return _EventType.TEST;
      default:
        return null;
    }
  }

  Future<void> execute(Map<dynamic, dynamic> data) async {
    switch (this) {
      case _EventType.DOWNLOAD:
        return _downloadEvent(data);
      case _EventType.GRAB:
        return _grabEvent(data);
      case _EventType.RENAME:
        return _renameEvent(data);
      case _EventType.RETAG:
        return _retagEvent(data);
      case _EventType.TEST:
        return _testEvent(data);
    }
  }

  Future<void> _downloadEvent(Map<dynamic, dynamic> data) async {
    return LunaModule.LIDARR.launch();
  }

  Future<void> _grabEvent(Map<dynamic, dynamic> data) async {
    return LunaModule.LIDARR.launch();
  }

  Future<void> _renameEvent(Map<dynamic, dynamic> data) async {
    return LunaModule.LIDARR.launch();
  }

  Future<void> _retagEvent(Map<dynamic, dynamic> data) async {
    return LunaModule.LIDARR.launch();
  }

  Future<void> _testEvent(Map<dynamic, dynamic> data) async {
    return LunaModule.LIDARR.launch();
  }
}
