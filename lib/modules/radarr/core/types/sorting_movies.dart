import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

part 'sorting_movies.g.dart';

@HiveType(typeId: 18, adapterName: 'RadarrMoviesSortingAdapter')
enum RadarrMoviesSorting {
    @HiveField(0)
    ALPHABETICAL
}

extension RadarrMoviesSortingExtension on RadarrMoviesSorting {
    String get key {
        switch(this) {
            case RadarrMoviesSorting.ALPHABETICAL: return 'abc';
            default: return null;
        }
    }

    String get readable {
        switch(this) {
            case RadarrMoviesSorting.ALPHABETICAL: return 'Alphabetical';
            default: return null;
        }
    }

    RadarrMoviesSorting fromKey(String key) {
        switch(key) {
            case 'abc': return RadarrMoviesSorting.ALPHABETICAL;
            default: return null;
        } 
    }

    List<RadarrMovie> sort(List<RadarrMovie> data, bool ascending) => _Sorter().byType(data, this, ascending);
}

class _Sorter {
    List<RadarrMovie> byType(
        List data,
        RadarrMoviesSorting type,
        bool ascending,
    ) {
        switch(type) {
            case RadarrMoviesSorting.ALPHABETICAL: return _alphabetical(data, ascending);
        }
        throw Exception('sorting type not found');
    }

    List<RadarrMovie> _alphabetical(List<RadarrMovie> series, bool ascending) {
        ascending
            ? series.sort((a,b) => a.sortTitle.toLowerCase().compareTo(b.sortTitle.toLowerCase()))
            : series.sort((a,b) => b.sortTitle.toLowerCase().compareTo(a.sortTitle.toLowerCase()));
        return series;
    }
}
