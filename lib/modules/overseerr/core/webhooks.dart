import 'package:lunasea/core.dart';
import 'package:lunasea/system/webhooks.dart';

class OverseerrWebhooks extends LunaWebhooks {
  @override
  Future<void> handle(Map<dynamic, dynamic> data) async {
    LunaLogger().warning('Unknown event type: ${data['event'] ?? 'null'}');
  }
}
