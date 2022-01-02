import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

part 'sorting_movies.g.dart';

@HiveType(typeId: 18, adapterName: 'RadarrMoviesSortingAdapter')
enum RadarrMoviesSorting {
  @HiveField(0)
  ALPHABETICAL,
  @HiveField(1)
  DATE_ADDED,
  @HiveField(8)
  DIGITAL_RELEASE,
  @HiveField(10)
  IN_CINEMAS,
  @HiveField(7)
  MIN_AVAILABILITY,
  @HiveField(9)
  PHYSICAL_RELEASE,
  @HiveField(2)
  QUALITY_PROFILE,
  @HiveField(3)
  RUNTIME,
  @HiveField(4)
  SIZE,
  @HiveField(5)
  STUDIO,
  @HiveField(6)
  YEAR,
}

extension RadarrMoviesSortingExtension on RadarrMoviesSorting {
  String get key {
    switch (this) {
      case RadarrMoviesSorting.ALPHABETICAL:
        return 'abc';
      case RadarrMoviesSorting.DATE_ADDED:
        return 'dateadded';
      case RadarrMoviesSorting.QUALITY_PROFILE:
        return 'qualityprofile';
      case RadarrMoviesSorting.RUNTIME:
        return 'runtime';
      case RadarrMoviesSorting.SIZE:
        return 'size';
      case RadarrMoviesSorting.STUDIO:
        return 'studio';
      case RadarrMoviesSorting.YEAR:
        return 'year';
      case RadarrMoviesSorting.MIN_AVAILABILITY:
        return 'minavailability';
      case RadarrMoviesSorting.IN_CINEMAS:
        return 'incinemas';
      case RadarrMoviesSorting.PHYSICAL_RELEASE:
        return 'physicalrelease';
      case RadarrMoviesSorting.DIGITAL_RELEASE:
        return 'digitalrelease';
    }
  }

  RadarrMoviesSorting? fromKey(String key) {
    switch (key) {
      case 'abc':
        return RadarrMoviesSorting.ALPHABETICAL;
      case 'dateadded':
        return RadarrMoviesSorting.DATE_ADDED;
      case 'qualityprofile':
        return RadarrMoviesSorting.QUALITY_PROFILE;
      case 'runtime':
        return RadarrMoviesSorting.RUNTIME;
      case 'size':
        return RadarrMoviesSorting.SIZE;
      case 'studio':
        return RadarrMoviesSorting.STUDIO;
      case 'year':
        return RadarrMoviesSorting.YEAR;
      case 'minavailability':
        return RadarrMoviesSorting.MIN_AVAILABILITY;
      case 'incinemas':
        return RadarrMoviesSorting.IN_CINEMAS;
      case 'physicalrelease':
        return RadarrMoviesSorting.PHYSICAL_RELEASE;
      case 'digitalrelease':
        return RadarrMoviesSorting.DIGITAL_RELEASE;
    }
    return null;
  }

  String get readable {
    switch (this) {
      case RadarrMoviesSorting.ALPHABETICAL:
        return 'radarr.Alphabetical'.tr();
      case RadarrMoviesSorting.DATE_ADDED:
        return 'radarr.DateAdded'.tr();
      case RadarrMoviesSorting.QUALITY_PROFILE:
        return 'radarr.QualityProfile'.tr();
      case RadarrMoviesSorting.RUNTIME:
        return 'radarr.Runtime'.tr();
      case RadarrMoviesSorting.SIZE:
        return 'radarr.Size'.tr();
      case RadarrMoviesSorting.STUDIO:
        return 'radarr.Studio'.tr();
      case RadarrMoviesSorting.YEAR:
        return 'radarr.Year'.tr();
      case RadarrMoviesSorting.MIN_AVAILABILITY:
        return 'radarr.MinimumAvailability'.tr();
      case RadarrMoviesSorting.DIGITAL_RELEASE:
        return 'radarr.DigitalRelease'.tr();
      case RadarrMoviesSorting.IN_CINEMAS:
        return 'radarr.InCinemas'.tr();
      case RadarrMoviesSorting.PHYSICAL_RELEASE:
        return 'radarr.PhysicalRelease'.tr();
    }
  }

  String value(RadarrMovie movie, RadarrQualityProfile? profile) {
    switch (this) {
      case RadarrMoviesSorting.ALPHABETICAL:
        return movie.lunaYear;
      case RadarrMoviesSorting.DATE_ADDED:
        return movie.lunaDateAdded(true);
      case RadarrMoviesSorting.DIGITAL_RELEASE:
        return movie.lunaDigitalReleaseDate(true);
      case RadarrMoviesSorting.IN_CINEMAS:
        return movie.lunaInCinemasOn(true);
      case RadarrMoviesSorting.MIN_AVAILABILITY:
        return movie.lunaMinimumAvailability;
      case RadarrMoviesSorting.PHYSICAL_RELEASE:
        return movie.lunaPhysicalReleaseDate(true);
      case RadarrMoviesSorting.QUALITY_PROFILE:
        return profile?.name ?? LunaUI.TEXT_EMDASH;
      case RadarrMoviesSorting.RUNTIME:
        return movie.lunaRuntime;
      case RadarrMoviesSorting.SIZE:
        return movie.lunaFileSize;
      case RadarrMoviesSorting.STUDIO:
        return movie.lunaStudio;
      case RadarrMoviesSorting.YEAR:
        return movie.lunaYear;
    }
  }

  List<RadarrMovie> sort(List<RadarrMovie> data, bool ascending) =>
      _Sorter().byType(data, this, ascending);
}

class _Sorter {
  List<RadarrMovie> byType(
    List<RadarrMovie> data,
    RadarrMoviesSorting type,
    bool ascending,
  ) {
    switch (type) {
      case RadarrMoviesSorting.DATE_ADDED:
        return _dateAdded(data, ascending);
      case RadarrMoviesSorting.QUALITY_PROFILE:
        return _qualityProfile(data, ascending);
      case RadarrMoviesSorting.RUNTIME:
        return _runtime(data, ascending);
      case RadarrMoviesSorting.SIZE:
        return _size(data, ascending);
      case RadarrMoviesSorting.STUDIO:
        return _studio(data, ascending);
      case RadarrMoviesSorting.YEAR:
        return _year(data, ascending);
      case RadarrMoviesSorting.MIN_AVAILABILITY:
        return _minimumAvailability(data, ascending);
      case RadarrMoviesSorting.ALPHABETICAL:
        return _alphabetical(data, ascending);
      case RadarrMoviesSorting.DIGITAL_RELEASE:
        return _digitalRelease(data, ascending);
      case RadarrMoviesSorting.IN_CINEMAS:
        return _inCinemas(data, ascending);
      case RadarrMoviesSorting.PHYSICAL_RELEASE:
        return _physicalRelease(data, ascending);
    }
  }

  List<RadarrMovie> _alphabetical(List<RadarrMovie> series, bool ascending) {
    ascending
        ? series.sort((a, b) =>
            a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase()))
        : series.sort((a, b) =>
            b.sortTitle!.toLowerCase().compareTo(a.sortTitle!.toLowerCase()));
    return series;
  }

  List<RadarrMovie> _dateAdded(List<RadarrMovie> movies, bool ascending) {
    movies.sort((a, b) {
      int? _comparison;
      if (a.added == null) _comparison = 1;
      if (b.added == null) _comparison = -1;
      if (a.added == null && b.added == null) _comparison = 0;
      if (a.added != null && b.added != null)
        _comparison = ascending
            ? a.added!.compareTo(b.added!)
            : b.added!.compareTo(a.added!);
      return _comparison == 0
          ? a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase())
          : _comparison!;
    });
    return movies;
  }

  List<RadarrMovie> _digitalRelease(List<RadarrMovie> movies, bool ascending) {
    movies.sort((a, b) {
      int? _comparison;
      if (a.digitalRelease == null) _comparison = 1;
      if (b.digitalRelease == null) _comparison = -1;
      if (a.digitalRelease == null && b.digitalRelease == null) _comparison = 0;
      if (a.digitalRelease != null && b.digitalRelease != null)
        _comparison = ascending
            ? a.digitalRelease!.compareTo(b.digitalRelease!)
            : b.digitalRelease!.compareTo(a.digitalRelease!);
      return _comparison == 0
          ? a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase())
          : _comparison!;
    });
    return movies;
  }

  List<RadarrMovie> _inCinemas(List<RadarrMovie> movies, bool ascending) {
    movies.sort((a, b) {
      int? _comparison;
      if (a.inCinemas == null) _comparison = 1;
      if (b.inCinemas == null) _comparison = -1;
      if (a.inCinemas == null && b.inCinemas == null) _comparison = 0;
      if (a.inCinemas != null && b.inCinemas != null)
        _comparison = ascending
            ? a.inCinemas!.compareTo(b.inCinemas!)
            : b.inCinemas!.compareTo(a.inCinemas!);
      return _comparison == 0
          ? a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase())
          : _comparison!;
    });
    return movies;
  }

  List<RadarrMovie> _minimumAvailability(
      List<RadarrMovie> movies, bool ascending) {
    movies.sort((a, b) {
      int? _comparison;
      if (a.minimumAvailability == null) _comparison = 1;
      if (b.minimumAvailability == null) _comparison = -1;
      if (a.minimumAvailability == null && b.minimumAvailability == null)
        _comparison = 0;
      if (a.minimumAvailability != null && b.minimumAvailability != null)
        _comparison = ascending
            ? a.minimumAvailability!.value
                .compareTo(b.minimumAvailability!.value)
            : b.minimumAvailability!.value
                .compareTo(a.minimumAvailability!.value);
      return _comparison == 0
          ? a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase())
          : _comparison!;
    });
    return movies;
  }

  List<RadarrMovie> _physicalRelease(List<RadarrMovie> movies, bool ascending) {
    movies.sort((a, b) {
      int? _comparison;
      if (a.physicalRelease == null) _comparison = 1;
      if (b.physicalRelease == null) _comparison = -1;
      if (a.physicalRelease == null && b.physicalRelease == null)
        _comparison = 0;
      if (a.physicalRelease != null && b.physicalRelease != null)
        _comparison = ascending
            ? a.physicalRelease!.compareTo(b.physicalRelease!)
            : b.physicalRelease!.compareTo(a.physicalRelease!);
      return _comparison == 0
          ? a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase())
          : _comparison!;
    });
    return movies;
  }

  List<RadarrMovie> _runtime(List<RadarrMovie> movies, bool ascending) {
    movies.sort((a, b) {
      int? _comparison;
      if (a.runtime == null || a.runtime == 0) _comparison = 1;
      if (b.runtime == null || b.runtime == 0) _comparison = -1;
      if ((a.runtime == null || a.runtime == 0) &&
          (b.runtime == null || b.runtime == 0)) _comparison = 0;
      if (a.runtime != null &&
          b.runtime != null &&
          a.runtime != 0 &&
          b.runtime != 0)
        _comparison = ascending
            ? a.runtime!.compareTo(b.runtime!)
            : b.runtime!.compareTo(a.runtime!);
      return _comparison == 0
          ? a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase())
          : _comparison!;
    });
    return movies;
  }

  List<RadarrMovie> _qualityProfile(List<RadarrMovie> movies, bool ascending) {
    movies.sort((a, b) {
      int? _comparison;
      if (a.qualityProfileId == null || a.qualityProfileId == 0)
        _comparison = 1;
      if (b.qualityProfileId == null || b.qualityProfileId == 0)
        _comparison = -1;
      if ((a.qualityProfileId == null || a.qualityProfileId == 0) &&
          (b.qualityProfileId == null || b.qualityProfileId == 0))
        _comparison = 0;
      if (a.qualityProfileId != null &&
          b.qualityProfileId != null &&
          a.qualityProfileId != 0 &&
          b.qualityProfileId != 0)
        _comparison = ascending
            ? a.qualityProfileId!.compareTo(b.qualityProfileId!)
            : b.qualityProfileId!.compareTo(a.qualityProfileId!);
      return _comparison == 0
          ? a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase())
          : _comparison!;
    });
    return movies;
  }

  List<RadarrMovie> _size(List<RadarrMovie> movies, bool ascending) {
    movies.sort((a, b) {
      int? _comparison;
      if (a.sizeOnDisk == null || a.sizeOnDisk == 0) _comparison = 1;
      if (b.sizeOnDisk == null || b.sizeOnDisk == 0) _comparison = -1;
      if ((a.sizeOnDisk == null || a.sizeOnDisk == 0) &&
          (b.sizeOnDisk == null || b.sizeOnDisk == 0)) _comparison = 0;
      if (a.sizeOnDisk != null &&
          b.sizeOnDisk != null &&
          a.sizeOnDisk != 0 &&
          b.sizeOnDisk != 0)
        _comparison = ascending
            ? a.sizeOnDisk!.compareTo(b.sizeOnDisk!)
            : b.sizeOnDisk!.compareTo(a.sizeOnDisk!);
      return _comparison == 0
          ? a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase())
          : _comparison!;
    });
    return movies;
  }

  List<RadarrMovie> _studio(List<RadarrMovie> movies, bool ascending) {
    movies.sort((a, b) {
      int? _comparison;
      if (a.studio == null || a.studio!.isEmpty) _comparison = 1;
      if (b.studio == null || b.studio!.isEmpty) _comparison = -1;
      if ((a.studio == null || a.studio!.isEmpty) &&
          (b.studio == null || b.studio!.isEmpty)) _comparison = 0;
      if (a.studio != null &&
          b.studio != null &&
          a.studio!.isNotEmpty &&
          b.studio!.isNotEmpty)
        _comparison = ascending
            ? (a.studio!.toLowerCase()).compareTo(b.studio!.toLowerCase())
            : (b.studio!.toLowerCase()).compareTo(a.studio!.toLowerCase());
      return _comparison == 0
          ? a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase())
          : _comparison!;
    });
    return movies;
  }

  List<RadarrMovie> _year(List<RadarrMovie> movies, bool ascending) {
    movies.sort((a, b) {
      int? _comparison;
      if (a.year == null || a.year == 0) _comparison = 1;
      if (b.year == null || b.year == 0) _comparison = -1;
      if ((a.year == null || a.year == 0) && (b.year == null || b.year == 0))
        _comparison = 0;
      if (a.year != null && b.year != null && a.year != 0 && b.year != 0)
        _comparison =
            ascending ? a.year!.compareTo(b.year!) : b.year!.compareTo(a.year!);
      return _comparison == 0
          ? a.sortTitle!.toLowerCase().compareTo(b.sortTitle!.toLowerCase())
          : _comparison!;
    });
    return movies;
  }
}
