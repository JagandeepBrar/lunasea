import 'package:lunasea/core.dart';

class OverseerrWebhooks extends LunaWebhooks {
    @override
    Future<void> handle(Map<dynamic, dynamic> data) async {
        LunaLogger().warning(
            'OverseerrWebhooks',
            'handle',
            'Unknown event type: ${data['event'] ?? 'null'}',
        );
    }
}
