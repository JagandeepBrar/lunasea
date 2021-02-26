import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrWebhooks extends LunaWebhooks {
    @override
    Future<void> handle(Map<dynamic, dynamic> data) async => _EventType.GRAB.fromKey(data['event'])?.execute(data);
}

enum _EventType {
    GRAB,
}

extension _EventTypeExtension on _EventType {
    _EventType fromKey(String key) {
        switch(key) {
            case 'grab': return _EventType.GRAB;
        }
        return null;
    }

    Future<void> execute(Map<dynamic, dynamic> data) async {
        switch(this) {
            case _EventType.GRAB: return _executeGrabEvent(data);
        }
    }

    Future<void> _executeGrabEvent(Map<dynamic, dynamic> data) async {
        int movieId = int.tryParse(data['id']);
        if(movieId != null) return RadarrMoviesDetailsRouter().navigateTo(
            LunaState.navigatorKey.currentContext,
            movieId: movieId,
        );
    }
}
