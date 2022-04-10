import 'package:lunasea/core.dart';

enum LunaLinks {
  BUILDS,
  CHANGELOG,
  DISCORD,
  DOCUMENTATION,
  FEEDBACK_BOARD,
  GITHUB,
  NOTIFICATIONS_GETTING_STARTED,
  REDDIT,
  BUILD_CHANNELS,
  WEBLATE,
  WEBSITE,
}

extension LunaLinksExtension on LunaLinks {
  String get url {
    switch (this) {
      case LunaLinks.BUILDS:
        return 'https://www.lunasea.app/builds';
      case LunaLinks.CHANGELOG:
        return 'https://www.lunasea.app/changelog';
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
      case LunaLinks.BUILD_CHANNELS:
        return 'https://www.lunasea.app/build-channels';
      case LunaLinks.WEBLATE:
        return 'https:/www.lunasea.app/translate';
      case LunaLinks.WEBSITE:
        return 'https://www.lunasea.app';
      case LunaLinks.NOTIFICATIONS_GETTING_STARTED:
        return 'https://docs.lunasea.app/lunasea/notifications';
    }
  }

  Future<void> launch() async => this.url.lunaOpenGenericLink();
}
