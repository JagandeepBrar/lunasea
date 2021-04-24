import 'package:lunasea/core.dart';

abstract class LunaWebhooks {
  /// Handle the incoming webhook for the module.
  Future<void> handle(Map<dynamic, dynamic> data);

  /// Given a [LunaModule] and Firebase UID, return the module's webhook endpoint for the user.
  static String buildUserTokenURL(String token, LunaModule module) =>
      'https://notify.lunasea.app/v1/${module.key}/user/$token';

  /// Given a [LunaModule] and Firebase device token, return the module's webhook endpoint for the device.
  static String buildDeviceTokenURL(String token, LunaModule module) =>
      'https://notify.lunasea.app/v1/${module.key}/device/$token';
}
