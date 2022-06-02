import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string_links.dart';

enum LunaLinks {
  CHANGELOG('https://www.lunasea.app/changelog'),
  BUILD_CHANNELS('https://www.lunasea.app/build-channels'),
  BUILDS('https://www.lunasea.app/builds'),
  DISCORD('https://www.lunasea.app/discord'),
  DOCUMENTATION('https://www.lunasea.app/docs'),
  FEEDBACK_BOARD('https://www.lunasea.app/feedback'),
  GITHUB('https://www.lunasea.app/github'),
  NOTIFICATIONS_DOC('https://docs.lunasea.app/lunasea/notifications'),
  REDDIT('https://www.lunasea.app/reddit'),
  WEBLATE('https:/www.lunasea.app/translate'),
  WEBSITE('https://www.lunasea.app');

  final String url;
  const LunaLinks(this.url);

  Future<void> launch() async => url.openLink();
}
