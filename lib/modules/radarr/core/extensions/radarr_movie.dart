import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

extension LunaRadarrMovieExtension on RadarrMovie {
    String get lunaRuntime {
        if(runtime != null && runtime != 0) return runtime.lunaRuntime();
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaAlternateTitles {
        if(alternateTitles != null && alternateTitles.length != 0) return alternateTitles.map<String>((title) => title.title).join('\n');
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaGenres {
        if(genres != null && genres.length != 0) return genres.join('\n');
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaStudio {
        if(studio != null && studio.isNotEmpty) return studio;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaYear {
        if(year != null && year != 0) return year.toString();
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaMinimumAvailability {
        if(minimumAvailability != null) return minimumAvailability.readable;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaDateAdded {
        if(added != null) return added.lunaDateReadable;
        return LunaUI.TEXT_EMDASH;
    }

    bool get lunaIsInCinemas {
        if(inCinemas != null) return inCinemas.toLocal().isBefore(DateTime.now());
        return false;
    }

    String get lunaInCinemasOn {
        if(inCinemas != null) return inCinemas.lunaDateReadable;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaPhysicalReleaseDate {
        if(physicalRelease != null) return physicalRelease.lunaDateReadable;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaDigitalReleaseDate {
        if(digitalRelease != null) return digitalRelease.lunaDateReadable;
        return LunaUI.TEXT_EMDASH;
    }

    String get lunaReleaseDate {
        if(lunaEarlierReleaseDate != null) return lunaEarlierReleaseDate.lunaDateReadable;
        return LunaUI.TEXT_EMDASH;
    }

    String lunaTags(List<RadarrTag> tags) {
        if(tags?.isNotEmpty ?? false) return tags.map<String>((tag) => tag.label).join('\n');
        return LunaUI.TEXT_EMDASH;
    }

    bool get lunaIsReleased {
        if(status == RadarrAvailability.RELEASED) return true;
        if(digitalRelease != null) return digitalRelease.toLocal().isBefore(DateTime.now());
        if(physicalRelease != null) return physicalRelease.toLocal().isBefore(DateTime.now());
        return false;
    }

    String get lunaFileSize {
        if(!hasFile) return LunaUI.TEXT_EMDASH;
        return sizeOnDisk.lunaBytesToString();
    }

    Text lunaHasFileTextObject(bool isMonitored) {
        if(hasFile) {
            return Text(
                lunaFileSize,
                style: TextStyle(
                    color: isMonitored ? LunaColours.accent : LunaColours.accent.withOpacity(0.30),
                    fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                    fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                ), 
            );
        }
        return Text('');
    }

    Text lunaNextReleaseTextObject(bool isMonitored) {
        DateTime now = DateTime.now();
        // If we already have a file or it is released
        if(hasFile || lunaIsReleased) return Text('');
        // In Cinemas
        if(inCinemas != null && inCinemas.toLocal().isAfter(now)) {
            String _date = inCinemas.lunaDaysDifference?.toUpperCase() ?? LunaUI.TEXT_EMDASH;
            return Text(
                _date == 'TODAY' ? _date : 'IN $_date',
                style: TextStyle(
                    color: isMonitored ? LunaColours.orange : LunaColours.orange.withOpacity(0.30),
                    fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                    fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                ),
            );
        }
        DateTime _release = lunaEarlierReleaseDate;
        // Releases
        if(_release != null) {
            String _date = _release.lunaDaysDifference?.toUpperCase() ?? LunaUI.TEXT_EMDASH;
            return Text(
                _date == 'TODAY' ? _date : 'IN $_date',
                style: TextStyle(
                    color: isMonitored ? LunaColours.blue : LunaColours.blue.withOpacity(0.30),
                    fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                    fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                ),
            );
        }
        // Unknown case
        return Text('');
    }

    /// Compare two movies by their release dates. Returns an integer value compatible with `.sort()` in arrays.
    /// 
    /// Compares and uses the earlier date between `phyiscalRelease` and `digitalRelease`.
    int lunaCompareToByReleaseDate(RadarrMovie movie) {
        if(physicalRelease == null && digitalRelease == null && movie.physicalRelease == null && movie.digitalRelease == null)
            return sortTitle.toLowerCase().compareTo(movie.sortTitle.toLowerCase());
        if(physicalRelease == null && digitalRelease == null) return 1;
        if(movie.physicalRelease == null && movie.digitalRelease == null) return -1;
        DateTime a = (physicalRelease ?? DateTime(9999)).isBefore((digitalRelease ?? DateTime(9999))) ? physicalRelease : digitalRelease;
        DateTime b = (movie.physicalRelease ?? DateTime(9999)).isBefore((movie.digitalRelease ?? DateTime(9999))) ? movie.physicalRelease : movie.digitalRelease;
        int comparison = a.compareTo(b);
        if(comparison == 0) comparison = sortTitle.toLowerCase().compareTo(movie.sortTitle.toLowerCase());
        return comparison;
    }

    /// Compare two movies by their cinema release date. Returns an integer value compatible with `.sort()` in arrays.
    int lunaCompareToByInCinemas(RadarrMovie movie) {
        if(inCinemas == null && movie.inCinemas == null) return sortTitle.toLowerCase().compareTo(movie.sortTitle.toLowerCase());
        if(inCinemas == null) return 1;
        if(movie.inCinemas == null) return -1;
        int comparison = inCinemas.compareTo(movie.inCinemas);
        if(comparison == 0) comparison = sortTitle.toLowerCase().compareTo(movie.sortTitle.toLowerCase());
        return comparison;
    }

    /// Compares the digital and physical release dates and returns the earlier date.
    /// 
    /// If both are null, returns null.
    DateTime get lunaEarlierReleaseDate {
        if(physicalRelease == null && digitalRelease == null) return null;
        if(physicalRelease == null) return digitalRelease;
        if(digitalRelease == null) return physicalRelease;
        return digitalRelease.isBefore(physicalRelease) ? digitalRelease : physicalRelease;
    }

    /// Creates a clone of the [RadarrMovie] object (deep copy).
    RadarrMovie clone() => RadarrMovie.fromJson(toJson());

    /// Copies changes from a [RadarrMoviesEditState] state object into a new [RadarrMovie] object.
    RadarrMovie updateEdits(RadarrMoviesEditState edits) {
        RadarrMovie movie = clone();
        movie.monitored = edits.monitored ?? monitored;
        movie.minimumAvailability = edits.availability ?? minimumAvailability;
        movie.qualityProfileId = edits.qualityProfile.id ?? qualityProfileId;
        movie.path = edits.path ?? path;
        movie.tags = edits.tags?.map((tag) => tag.id)?.toList() ?? tags;
        return movie;
    }
}
