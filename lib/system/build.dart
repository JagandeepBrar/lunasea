import 'package:lunasea/database/tables/lunasea.dart';
import 'package:lunasea/extensions/string/links.dart';
import 'package:lunasea/system/environment.dart';
import 'package:lunasea/system/logger.dart';
import 'package:lunasea/system/platform.dart';
import 'package:lunasea/vendor.dart';

class LunaBuild {
  // Returns the first 7 characters of the commit hash of this build
  String get shortCommit {
    const commit = LunaEnvironment.commit;
    return commit.substring(0, min(7, commit.length));
  }

  String getCommitUrl(
    String commit, {
    bool fullHistory = false,
  }) {
    final location = fullHistory ? 'commits' : 'commit';
    return 'https://github.com/JagandeepBrar/LunaSea/$location/$commit';
  }

  Future<void> openCommitHistory({String? commit}) async {
    return getCommitUrl(LunaEnvironment.commit, fullHistory: true).openLink();
  }

  Future<Tuple2<bool, int?>> isLatestBuildNumber() async {
    try {
      final latest = await LunaPlatform.current.getLatestBuildNumber();
      const current = LunaEnvironment.build;
      return Tuple2(latest > current, latest);
    } catch (error, stack) {
      LunaLogger().error(
        'Failed to check if running latest build number',
        error,
        stack,
      );
    }

    return const Tuple2(false, null);
  }

  Future<Tuple2<bool, int>> isLatestBuildVersion() async {
    const database = LunaSeaDatabase.CHANGELOG_LAST_BUILD_VERSION;
    const build = LunaEnvironment.build;

    bool isLatest = true;
    if (build > database.read()) isLatest = false;

    database.update(build);
    return Tuple2(isLatest, build);
  }
}
