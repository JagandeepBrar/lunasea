import 'package:lunasea/core.dart';

enum LunaLinks {
  CHANGELOG,
  CRASHLYTICS,
  DISCORD,
  DOCUMENTATION,
  FEEDBACK_BOARD,
  GITHUB,
  NOTIFICATIONS_GETTING_STARTED,
  REDDIT,
  SYSTEM_STATUS,
  TESTFLIGHT,
  WEBLATE,
  WEBSITE,
}

extension LunaLinksExtension on LunaLinks {
  String get url {
    switch (this) {
      case LunaLinks.CHANGELOG:
        return 'https://www.lunasea.app/changelog';
      case LunaLinks.CRASHLYTICS:
        return 'https://firebase.google.com/products/crashlytics';
      case LunaLinks.DISCORD:
        return 'https://www.lunasea.app/discord';
      case LunaLinks.DOCUMENTATION:
        return 'https://www.lunasea.app/docs';
      case LunaLinks.FEEDBACK_BOARD:
        return 'https://www.lunasea.app/feedback';
      case LunaLinks.GITHUB:
        return 'https://www.lunasea.app/github';
      case LunaLinks.REDDIT:
        return 'https://www.lunasea.app/reddit';
      case LunaLinks.SYSTEM_STATUS:
        return 'https://www.lunasea.app/status';
      case LunaLinks.TESTFLIGHT:
        return 'https://www.lunasea.app/testflight';
      case LunaLinks.WEBLATE:
        return 'https:/www.lunasea.app/translate';
      case LunaLinks.WEBSITE:
        return 'https://www.lunasea.app';
      case LunaLinks.NOTIFICATIONS_GETTING_STARTED:
        return 'https://docs.lunasea.app/lunasea/notifications';
    }
    throw Exception('Invalid LunaLinks');
  }

  Future<void> launch() async => this?.url?.lunaOpenGenericLink();
}
