import 'package:lunasea/extensions/string_links.dart';
import 'package:lunasea/system/environment.dart';
import 'package:lunasea/system/logger.dart';
import 'package:lunasea/system/platform.dart';
import 'package:lunasea/vendor.dart';

class LunaBuild {
  String get versionEndpoint {
    const base = 'https://downloads.lunasea.app/latest/';
    const flavor = LunaEnvironment.flavor;

    switch (LunaPlatform.current) {
      case LunaPlatform.ANDROID:
        return '$base/$flavor/VERSION_ANDROID.txt';
      case LunaPlatform.IOS:
        return '$base/$flavor/VERSION_IOS.txt';
      case LunaPlatform.LINUX:
        return '$base/$flavor/VERSION_LINUX.txt';
      case LunaPlatform.MACOS:
        return '$base/$flavor/VERSION_MACOS.txt';
      case LunaPlatform.WEB:
        return '$base/$flavor/VERSION_WEB.txt';
      case LunaPlatform.WINDOWS:
        return '$base/$flavor/VERSION_WINDOWS.txt';
    }
  }

  // Returns the first 7 characters of the commit hash of this build
  String get shortCommit {
    const commit = LunaEnvironment.commit;
    return commit.substring(0, min(7, commit.length));
  }

  Future<bool> checkForUpdates() async {
    try {
      final result = await Dio()
          .get(versionEndpoint)
          .then((response) => response.data as String);

      final latestVersion = int.parse(result);
      final currentVersion = int.parse(LunaEnvironment.build);
      return latestVersion > currentVersion;
    } catch (error, stack) {
      LunaLogger().error('Failed to check for updates', error, stack);
    }

    return false;
  }

  Future<void> openCommitHistory() async {
    const commit = LunaEnvironment.commit;
    String _base = 'https://github.com/JagandeepBrar/LunaSea/commits';
    return '$_base/$commit'.openLink();
  }
}
