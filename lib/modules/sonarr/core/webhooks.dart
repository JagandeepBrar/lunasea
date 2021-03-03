import 'package:lunasea/core.dart';
//import 'package:lunasea/modules/sonarr.dart';

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
    GRAB,
}

extension _EventTypeExtension on _EventType {
    _EventType fromKey(String key) {
        switch(key) {
            case 'Grab': return _EventType.GRAB;
        }
        return null;
    }

    Future<void> execute(Map<dynamic, dynamic> data) async {
        // TODO
        switch(this) {
            case _EventType.GRAB: return _grabEvent(data);
        }
    }

    Future<void> _grabEvent(Map<dynamic, dynamic> data) async {}
}
