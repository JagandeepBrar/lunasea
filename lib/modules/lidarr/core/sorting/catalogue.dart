import 'package:lunasea/modules/lidarr.dart';

enum LidarrCatalogueSorting {
  alphabetical,
  dateAdded,
  metadata,
  quality,
  size,
  tracks,
  type,
}

extension LidarrCatalogueSortingExtension on LidarrCatalogueSorting {
  String get value {
    switch (this) {
      case LidarrCatalogueSorting.alphabetical:
        return 'abc';
      case LidarrCatalogueSorting.dateAdded:
        return 'date_added';
      case LidarrCatalogueSorting.size:
        return 'size';
      case LidarrCatalogueSorting.metadata:
        return 'metadata';
      case LidarrCatalogueSorting.quality:
        return 'quality';
      case LidarrCatalogueSorting.tracks:
        return 'tracks';
      case LidarrCatalogueSorting.type:
        return 'type';
    }
  }

  String get readable {
    switch (this) {
      case LidarrCatalogueSorting.alphabetical:
        return 'Alphabetical';
      case LidarrCatalogueSorting.dateAdded:
        return 'Date Added';
      case LidarrCatalogueSorting.size:
        return 'Size';
      case LidarrCatalogueSorting.metadata:
        return 'Metadata Profile';
      case LidarrCatalogueSorting.quality:
        return 'Quality Profile';
      case LidarrCatalogueSorting.tracks:
        return 'Tracks';
      case LidarrCatalogueSorting.type:
        return 'Type';
    }
  }

  List<LidarrCatalogueData> sort(List data, bool ascending) =>
      _Sorter().byType(data, this, ascending) as List<LidarrCatalogueData>;
}

class _Sorter {
  List byType(
    List data,
    LidarrCatalogueSorting type,
    bool ascending,
  ) {
    switch (type) {
      case LidarrCatalogueSorting.alphabetical:
        return _alphabetical(data, ascending);
      case LidarrCatalogueSorting.dateAdded:
        return _dateAdded(data, ascending);
      case LidarrCatalogueSorting.size:
        return _size(data, ascending);
      case LidarrCatalogueSorting.metadata:
        return _metadata(data, ascending);
      case LidarrCatalogueSorting.quality:
        return _quality(data, ascending);
      case LidarrCatalogueSorting.tracks:
        return _tracks(data, ascending);
      case LidarrCatalogueSorting.type:
        return _type(data, ascending);
    }
  }

  List<LidarrCatalogueData> _alphabetical(List data, bool ascending) {
    List<LidarrCatalogueData> _data = List.from(data, growable: false);
    ascending
        ? _data.sort((a, b) => a.sortTitle.compareTo(b.sortTitle))
        : _data.sort((a, b) => b.sortTitle.compareTo(a.sortTitle));
    return _data;
  }

  List<LidarrCatalogueData> _dateAdded(List data, bool ascending) {
    List<LidarrCatalogueData> _data = _alphabetical(data, true);
    List<LidarrCatalogueData> _hasNoDate =
        _data.where((item) => item.dateAddedObject == null).toList();
    List<LidarrCatalogueData> _hasDate =
        _data.where((item) => item.dateAddedObject != null).toList();
    _hasDate.sort((a, b) {
      return ascending
          ? a.dateAddedObject!.compareTo(b.dateAddedObject!)
          : b.dateAddedObject!.compareTo(a.dateAddedObject!);
    });
    return [..._hasDate, ..._hasNoDate];
  }

  List<LidarrCatalogueData> _size(List data, bool ascending) {
    List<LidarrCatalogueData> _data = _alphabetical(data, true);
    ascending
        ? _data.sort((a, b) => a.sizeOnDisk.compareTo(b.sizeOnDisk))
        : _data.sort((a, b) => b.sizeOnDisk.compareTo(a.sizeOnDisk));
    return _data;
  }

  List<LidarrCatalogueData> _quality(List data, bool ascending) {
    List<LidarrCatalogueData> _data = _alphabetical(data, true);
    ascending
        ? _data.sort((a, b) => a.qualityProfile!.compareTo(b.qualityProfile!))
        : _data.sort((a, b) => b.qualityProfile!.compareTo(a.qualityProfile!));
    return _data;
  }

  List<LidarrCatalogueData> _metadata(List data, bool ascending) {
    List<LidarrCatalogueData> _data = _alphabetical(data, true);
    ascending
        ? _data.sort((a, b) => a.metadataProfile!.compareTo(b.metadataProfile!))
        : _data
            .sort((a, b) => b.metadataProfile!.compareTo(a.metadataProfile!));
    return _data;
  }

  List<LidarrCatalogueData> _tracks(List data, bool ascending) {
    List<LidarrCatalogueData> _data = List.from(data, growable: false);
    ascending
        ? _data.sort((a, b) => a.statistics['percentOfTracks']
            .compareTo(b.statistics['percentOfTracks']))
        : _data.sort((a, b) => b.statistics['percentOfTracks']
            .compareTo(a.statistics['percentOfTracks']));
    return _data;
  }

  List<LidarrCatalogueData> _type(List data, bool ascending) {
    List<LidarrCatalogueData> _data = _alphabetical(data, true);
    ascending
        ? _data.sort((a, b) => a.artistType.compareTo(b.artistType))
        : _data.sort((a, b) => b.artistType.compareTo(a.artistType));
    return _data;
  }
}
