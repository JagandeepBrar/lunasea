import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

extension RadarrSystemStatusExtension on RadarrSystemStatus {
    String get lunaVersion {
        if(this.version != null && this.version.isNotEmpty) return this.version;
        return Constants.TEXT_EMDASH;
    }

    String get lunaPackageVersion {
        String packageAuthor, packageVersion;
        if(this.packageVersion != null && this.packageVersion.isNotEmpty) packageVersion = this.packageVersion;
        if(this.packageAuthor != null && this.packageAuthor.isNotEmpty) packageAuthor = this.packageAuthor;
        return '${packageVersion ?? Constants.TEXT_EMDASH} by ${packageAuthor ?? Constants.TEXT_EMDASH}';
    }

    String get lunaNetCore {
        if(this.isNetCore ?? false) return 'Yes (${this.runtimeVersion ?? Constants.TEXT_EMDASH})';
        return 'No';
    }

    String get lunaDocker {
        if(this.isDocker ?? false) return 'Yes';
        return 'No';
    }

    String get lunaDBMigration {
        if(this.migrationVersion != null) return '${this.migrationVersion}';
        return Constants.TEXT_EMDASH;
    }

    String get lunaAppDataDirectory {
        if(this.appData != null && this.appData.isNotEmpty) return this.appData;
        return Constants.TEXT_EMDASH;
    }

    String get lunaStartupDirectory {
        if(this.startupPath != null && this.startupPath.isNotEmpty) return this.startupPath;
        return Constants.TEXT_EMDASH;
    }

    String get lunaMode {
        if(this.mode != null && this.mode.isNotEmpty) return this.mode.lunaCapitalizeFirstLetters();
        return Constants.TEXT_EMDASH;
    }

    String get lunaUptime {
        if(this.startTime != null && this.startTime.isNotEmpty) {
            DateTime _start = DateTime.tryParse(this.startTime);
            if(_start != null) return DateTime.now().difference(_start).lunaTimestampWords;
        }
        return Constants.TEXT_EMDASH;
    }
}