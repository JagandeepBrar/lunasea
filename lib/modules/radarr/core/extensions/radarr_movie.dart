import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/datetime.dart';
import 'package:lunasea/extensions/int/bytes.dart';
import 'package:lunasea/extensions/int/duration.dart';
import 'package:lunasea/modules/radarr.dart';

extension LunaRadarrMovieExtension on RadarrMovie {
  String get lunaRuntime {
    return this.runtime.asVideoDuration();
  }

  String get lunaAlternateTitles {
    if (this.alternateTitles?.isNotEmpty ?? false) {
      return this.alternateTitles!.map((title) => title.title).join('\n');
    }
    return LunaUI.TEXT_EMDASH;
  }

  String get lunaGenres {
    if (this.genres?.isNotEmpty ?? false) return this.genres!.join('\n');
    return LunaUI.TEXT_EMDASH;
  }

  String get lunaStudio {
    if (this.studio?.isNotEmpty ?? false) return this.studio!;
    return LunaUI.TEXT_EMDASH;
  }

  String get lunaYear {
    if (this.year != null && this.year != 0) return this.year.toString();
    return LunaUI.TEXT_EMDASH;
  }

  String get lunaMinimumAvailability {
    if (this.minimumAvailability != null) {
      return this.minimumAvailability!.readable;
    }
    return LunaUI.TEXT_EMDASH;
  }

  String lunaDateAdded([bool short = false]) {
    if (this.added != null) return this.added!.asDateOnly(shortenMonth: short);
    return LunaUI.TEXT_EMDASH;
  }

  bool get lunaIsInCinemas {
    if (this.inCinemas != null)
      return this.inCinemas!.toLocal().isBefore(DateTime.now());
    return false;
  }

  String lunaInCinemasOn([bool short = false]) {
    if (this.inCinemas != null)
      return this.inCinemas!.asDateOnly(shortenMonth: short);
    return LunaUI.TEXT_EMDASH;
  }

  String lunaPhysicalReleaseDate([bool short = false]) {
    if (this.physicalRelease != null)
      return this.physicalRelease!.asDateOnly(shortenMonth: short);
    return LunaUI.TEXT_EMDASH;
  }

  String lunaDigitalReleaseDate([bool short = false]) {
    if (this.digitalRelease != null)
      return this.digitalRelease!.asDateOnly(shortenMonth: short);
    return LunaUI.TEXT_EMDASH;
  }

  String get lunaReleaseDate {
    if (this.lunaEarlierReleaseDate != null)
      return this.lunaEarlierReleaseDate!.asDateOnly();
    return LunaUI.TEXT_EMDASH;
  }

  String lunaTags(List<RadarrTag> tags) {
    if (tags.isNotEmpty) return tags.map<String?>((t) => t.label).join('\n');
    return LunaUI.TEXT_EMDASH;
  }

  bool get lunaIsReleased {
    if (this.status == RadarrAvailability.RELEASED) return true;
    if (this.digitalRelease != null)
      return this.digitalRelease!.toLocal().isBefore(DateTime.now());
    if (this.physicalRelease != null)
      return this.physicalRelease!.toLocal().isBefore(DateTime.now());
    return false;
  }

  String get lunaFileSize {
    if (!this.hasFile!) return LunaUI.TEXT_EMDASH;
    return this.sizeOnDisk.asBytes();
  }

  Text lunaHasFileTextObject() {
    if (this.hasFile!)
      return Text(
        lunaFileSize,
        style: const TextStyle(
          color: LunaColours.accent,
          fontSize: LunaUI.FONT_SIZE_H3,
          fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        ),
      );
    return const Text(
      '',
      style: TextStyle(
        fontSize: LunaUI.FONT_SIZE_H3,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
      ),
    );
  }

  Text lunaNextReleaseTextObject() {
    DateTime now = DateTime.now();
    // If we already have a file or it is released
    if (this.hasFile! || lunaIsReleased)
      return const Text(
        '',
        style: TextStyle(fontSize: LunaUI.FONT_SIZE_H3),
      );
    // In Cinemas
    if (this.inCinemas != null && this.inCinemas!.toLocal().isAfter(now)) {
      String _date = this.inCinemas!.asDaysDifference().toUpperCase();
      return Text(
        _date == 'TODAY' ? _date : 'IN $_date',
        style: const TextStyle(
          color: LunaColours.orange,
          fontSize: LunaUI.FONT_SIZE_H3,
          fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        ),
      );
    }
    DateTime? _release = lunaEarlierReleaseDate;
    // Releases
    if (_release != null) {
      String _date = _release.asDaysDifference().toUpperCase();
      return Text(
        _date == 'TODAY' ? _date : 'IN $_date',
        style: const TextStyle(
          color: LunaColours.blue,
          fontSize: LunaUI.FONT_SIZE_H3,
          fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        ),
      );
    }
    // Unknown case
    return const Text(
      '',
      style: TextStyle(
        fontSize: LunaUI.FONT_SIZE_H3,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
      ),
    );
  }

  /// Compare two movies by their release dates. Returns an integer value compatible with `.sort()` in arrays.
  ///
  /// Compares and uses the earlier date between `physicalRelease` and `digitalRelease`.
  int lunaCompareToByReleaseDate(RadarrMovie movie) {
    if (this.physicalRelease == null &&
        this.digitalRelease == null &&
        movie.physicalRelease == null &&
        movie.digitalRelease == null)
      return this
          .sortTitle!
          .toLowerCase()
          .compareTo(movie.sortTitle!.toLowerCase());
    if (this.physicalRelease == null && this.digitalRelease == null) return 1;
    if (movie.physicalRelease == null && movie.digitalRelease == null)
      return -1;
    DateTime a = (this.physicalRelease ?? DateTime(9999))
            .isBefore((this.digitalRelease ?? DateTime(9999)))
        ? this.physicalRelease!
        : this.digitalRelease!;
    DateTime b = (movie.physicalRelease ?? DateTime(9999))
            .isBefore((movie.digitalRelease ?? DateTime(9999)))
        ? movie.physicalRelease!
        : movie.digitalRelease!;
    int comparison = a.compareTo(b);
    if (comparison == 0)
      comparison = this
          .sortTitle!
          .toLowerCase()
          .compareTo(movie.sortTitle!.toLowerCase());
    return comparison;
  }

  /// Compare two movies by their cinema release date. Returns an integer value compatible with `.sort()` in arrays.
  int lunaCompareToByInCinemas(RadarrMovie movie) {
    if (this.inCinemas == null && movie.inCinemas == null)
      return this
          .sortTitle!
          .toLowerCase()
          .compareTo(movie.sortTitle!.toLowerCase());
    if (this.inCinemas == null) return 1;
    if (movie.inCinemas == null) return -1;
    int comparison = this.inCinemas!.compareTo(movie.inCinemas!);
    if (comparison == 0)
      comparison = this
          .sortTitle!
          .toLowerCase()
          .compareTo(movie.sortTitle!.toLowerCase());
    return comparison;
  }

  /// Compares the digital and physical release dates and returns the earlier date.
  ///
  /// If both are null, returns null.
  DateTime? get lunaEarlierReleaseDate {
    if (this.physicalRelease == null && this.digitalRelease == null)
      return null;
    if (this.physicalRelease == null) return this.digitalRelease;
    if (this.digitalRelease == null) return this.physicalRelease;
    return this.digitalRelease!.isBefore(this.physicalRelease!)
        ? this.digitalRelease
        : this.physicalRelease;
  }

  /// Creates a clone of the [RadarrMovie] object (deep copy).
  RadarrMovie clone() => RadarrMovie.fromJson(this.toJson());

  /// Copies changes from a [RadarrMoviesEditState] state object into a new [RadarrMovie] object.
  RadarrMovie updateEdits(RadarrMoviesEditState edits) {
    RadarrMovie movie = this.clone();
    movie.monitored = edits.monitored;
    movie.minimumAvailability = edits.availability;
    movie.qualityProfileId = edits.qualityProfile.id ?? this.qualityProfileId;
    movie.path = edits.path;
    movie.tags = edits.tags.map((t) => t.id).toList();
    return movie;
  }
}
