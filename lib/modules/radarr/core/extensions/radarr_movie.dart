import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

extension LunaRadarrMovieExtension on RadarrMovie {
    String get lunaRuntime {
        if(this.runtime != null && this.runtime != 0) return this.runtime.lunaRuntime();
        return Constants.TEXT_EMDASH;
    }

    String get lunaStudio {
        if(this.studio != null && this.studio.isNotEmpty) return this.studio;
        return Constants.TEXT_EMDASH;
    }

    String get lunaYear {
        if(this.year != null && this.year != 0) return this.year.toString();
        return Constants.TEXT_EMDASH;
    }

    String get lunaMinimumAvailability {
        if(this.minimumAvailability != null) return this.minimumAvailability.readable;
        return Constants.TEXT_EMDASH;
    }

    String get lunaDateAdded {
        if(this.added != null) return DateFormat('MMMM dd, y').format(this.added.toLocal());
        return Constants.TEXT_EMDASH;
    }

    bool get lunaInCinemas {
        if(this.inCinemas != null) return this.inCinemas.toLocal().isBefore(DateTime.now());
        return false;
    }

    bool get lunaIsReleased {
        if(this.status == RadarrAvailability.RELEASED) return true;
        if(this.digitalRelease != null) return this.digitalRelease.toLocal().isBefore(DateTime.now());
        if(this.physicalRelease != null) return this.physicalRelease.toLocal().isBefore(DateTime.now());
        return false;
    }

    String get lunaFileSize {
        if(!this.hasFile) return Constants.TEXT_EMDASH;
        return this.sizeOnDisk.lunaBytesToString();
    }

    Text get lunaHasFileTextObject {
        if(this.hasFile) return Text(
            lunaFileSize,
            style: TextStyle(
                color: LunaColours.accent,
                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                fontWeight: FontWeight.w600,
            ), 
        );
        return Text('');
    }

    Text get lunaNextReleaseTextObject {
        DateTime now = DateTime.now();
        // If we already have a file or it is released
        if(this.hasFile || lunaIsReleased) return Text('');
        // In Cinemas
        if(this.inCinemas != null && this.inCinemas.toLocal().isAfter(now)) return Text(
            'IN ${this.inCinemas.lunaDaysDifference.toUpperCase()}',
            style: TextStyle(
                color: LunaColours.orange,
                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                fontWeight: FontWeight.w600,
            ),
        );
        // Releases
        if(this.digitalRelease != null && this.digitalRelease.toLocal().isAfter(now)) return Text(
            'IN ${this.digitalRelease.lunaDaysDifference.toUpperCase()}',
            style: TextStyle(
                color: LunaColours.blue,
                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                fontWeight: FontWeight.w600,
            ),
        );
        if(this.physicalRelease != null && this.physicalRelease.toLocal().isAfter(now)) return Text(
            'IN ${this.physicalRelease.lunaDaysDifference.toUpperCase()}',
            style: TextStyle(
                color: LunaColours.blue,
                fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                fontWeight: FontWeight.w600,
            ),
        );
        // Unknown case
        return Text('');
    }

    /// Compare two movies by their release dates. Returns an integer value compatible with `.sort()` in arrays.
    /// 
    /// Compares and uses the earlier date between `phyiscalRelease` and `digitalRelease`.
    int lunaCompareToByReleaseDate(RadarrMovie movie) {
        if(this.physicalRelease == null && this.digitalRelease == null && movie.physicalRelease == null && movie.digitalRelease == null)
            return this.sortTitle.toLowerCase().compareTo(movie.sortTitle.toLowerCase());
        if(this.physicalRelease == null && this.digitalRelease == null) return 1;
        if(movie.physicalRelease == null && movie.digitalRelease == null) return -1;
        DateTime a = (this.physicalRelease ?? DateTime(9999)).isBefore((this.digitalRelease ?? DateTime(9999))) ? this.physicalRelease : this.digitalRelease;
        DateTime b = (movie.physicalRelease ?? DateTime(9999)).isBefore((movie.digitalRelease ?? DateTime(9999))) ? movie.physicalRelease : movie.digitalRelease;
        int comparison = a.compareTo(b);
        if(comparison == 0) comparison = this.sortTitle.toLowerCase().compareTo(movie.sortTitle.toLowerCase());
        return comparison;
    }

    /// Compare two movies by their cinema release date. Returns an integer value compatible with `.sort()` in arrays.
    int lunaCompareToByInCinemas(RadarrMovie movie) {
        if(this.inCinemas == null && movie.inCinemas == null) return this.sortTitle.toLowerCase().compareTo(movie.sortTitle.toLowerCase());
        if(this.inCinemas == null) return 1;
        if(movie.inCinemas == null) return -1;
        int comparison = this.inCinemas.compareTo(movie.inCinemas);
        if(comparison == 0) comparison = this.sortTitle.toLowerCase().compareTo(movie.sortTitle.toLowerCase());
        return comparison;
    }

    /// Compares the digital and physical release dates and returns the earlier date.
    /// 
    /// If both are null, returns null.
    DateTime get lunaEarlierReleaseDate {
        if(this.physicalRelease == null && this.digitalRelease == null) return null;
        if(this.physicalRelease == null) return this.digitalRelease;
        if(this.digitalRelease == null) return this.physicalRelease;
        return this.digitalRelease.isBefore(this.physicalRelease) ? this.digitalRelease : this.physicalRelease;
    }
}
