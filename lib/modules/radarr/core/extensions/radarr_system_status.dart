import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

extension RadarrSystemStatusExtension on RadarrSystemStatus {
    String get lunaVersion {
        if(version != null && version.isNotEmpty) return version;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaPackageVersion {
        String packageAuthor, packageVersion;
        if(packageVersion != null && packageVersion.isNotEmpty) packageVersion = packageVersion;
        if(packageAuthor != null && packageAuthor.isNotEmpty) packageAuthor = packageAuthor;
        return '${packageVersion ?? LunaUI.TEXT_EMDASH} by ${packageAuthor ?? LunaUI.TEXT_EMDASH}';
    }

    String get lunaNetCore {
        if(isNetCore ?? false) return 'Yes (${runtimeVersion ?? LunaUI.TEXT_EMDASH})';
        return 'No';
    }

    String get lunaDocker {
        if(isDocker ?? false) return 'Yes';
        return 'No';
    }

    String get lunaDBMigration {
        if(migrationVersion != null) return '${migrationVersion}';
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaAppDataDirectory {
        if(appData != null && appData.isNotEmpty) return appData;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaStartupDirectory {
        if(startupPath != null && startupPath.isNotEmpty) return startupPath;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaMode {
        if(mode != null && mode.isNotEmpty) return mode.lunaCapitalizeFirstLetters();
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaUptime {
        if(startTime != null && startTime.isNotEmpty) {
            DateTime _start = DateTime.tryParse(startTime);
            if(_start != null) return DateTime.now().difference(_start).lunaTimestampWords;
        }
        return LunaUI.TEXT_EMDASH;
    }
}
