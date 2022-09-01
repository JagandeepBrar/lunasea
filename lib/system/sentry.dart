import 'package:lunasea/database/tables/bios.dart';
import 'package:lunasea/system/environment.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class LunaSentry {
  Future<void> initialize() async {
    await SentryFlutter.init((options) {
      options.dsn = LunaEnvironment.sentryDSN;
      options.environment = LunaEnvironment.flavor;
      options.release = LunaEnvironment.commit;
    });
  }

  Future<void> captureException(dynamic error, StackTrace? stackTrace) async {
    if (!BIOSDatabase.SENTRY_LOGGING.read()) return;
    await Sentry.captureException(error, stackTrace: stackTrace);
  }

  SentryNavigatorObserver get navigatorObserver => SentryNavigatorObserver();
}
