import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';

enum SearchResultsSorting {
    age,
    alphabetical,
    size,
}

extension SearchResultsSortingExtension on SearchResultsSorting {
    static _Sorter _sorter = _Sorter();

    String get value {
        switch(this) {
            case SearchResultsSorting.alphabetical: return 'abc';
            case SearchResultsSorting.size: return 'size';
            case SearchResultsSorting.age: return 'age';
        }
        throw Exception('value not found');
    }

    String get readable {
        switch(this) {
            case SearchResultsSorting.alphabetical: return 'Alphabetical';
            case SearchResultsSorting.size: return 'Size';
            case SearchResultsSorting.age: return 'Age';
        }
        throw Exception('readable not found');
    }

    List<NewznabResultData> sort(
        List data,
        bool ascending
    ) => _sorter.byType(data, this, ascending);
}

class _Sorter extends Sorter<SearchResultsSorting> {
    @override
    List byType(
        List data,
        SearchResultsSorting type,
        bool ascending,
    ) {
        switch(type) {
            case SearchResultsSorting.alphabetical: return _alphabetical(data, ascending);
            case SearchResultsSorting.size: return _size(data, ascending);
            case SearchResultsSorting.age: return _age(data, ascending);
        }
        throw Exception('sorting type not found');
    }

    List<NewznabResultData> _alphabetical(List data, bool ascending) {
        List<NewznabResultData> _data = new List<NewznabResultData>.from(data, growable: false);
        ascending
            ? _data.sort((a,b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()))
            : _data.sort((a,b) => b.title.toLowerCase().compareTo(a.title.toLowerCase()));
        return _data;
    }

    List<NewznabResultData> _size(List data, bool ascending) {
        List<NewznabResultData> _data = new List<NewznabResultData>.from(data, growable: false);
        ascending
            ? _data.sort((a,b) => a.size.compareTo(b.size))
            : _data.sort((a,b) => b.size.compareTo(a.size));
        return _data;
    }

    List<NewznabResultData> _age(List data, bool ascending) {
        List<NewznabResultData> _data = new List<NewznabResultData>.from(data, growable: false);
        ascending
            ? _data.sort((a,b) => b.posix.compareTo(a.posix))
            : _data.sort((a,b) => a.posix.compareTo(b.posix));
        return _data;
    }
}