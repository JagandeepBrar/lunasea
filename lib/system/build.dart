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

  Future<void> openCommitHistory() async {
    const commit = LunaEnvironment.commit;
    String _base = 'https://github.com/JagandeepBrar/LunaSea/commits';
    return '$_base/$commit'.openLink();
  }

  Future<Tuple2<bool, int?>> isLatestBuildNumber() async {
    try {
      final latest = await LunaPlatform.current.getLatestBuildNumber();
      final current = int.parse(LunaEnvironment.build);
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

  Future<Tuple2<bool, String?>> isLatestBuildVersion() async {
    List<int> _parse(String v) =>
        v.split('.').map((s) => int.parse(s)).toList();

    try {
      const database = LunaSeaDatabase.CHANGELOG_LAST_BUILD;
      final package = (await PackageInfo.fromPlatform()).version;

      final currentVersion = _parse(database.read());
      final runningVersion = _parse(package);

      bool isLatest = true;
      if (runningVersion[0] != currentVersion[0]) {
        isLatest = false;
      } else if (runningVersion[1] != currentVersion[1]) {
        isLatest = false;
      } else if (runningVersion[2] != currentVersion[2]) {
        isLatest = false;
      }

      database.update(package);
      return Tuple2(isLatest, package);
    } catch (error, stack) {
      LunaLogger().error(
        'Failed to check if running latest build version',
        error,
        stack,
      );
    }

    return const Tuple2(false, null);
  }
}
