import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrReleasesState extends ChangeNotifier {
  final int? authorId;
  final int? bookId;

  ReadarrReleasesState({
    required BuildContext context,
    this.authorId,
    this.bookId,
  }) {
    refreshReleases(context);
  }

  Future<List<ReadarrRelease>>? _releases;
  Future<List<ReadarrRelease>>? get releases => _releases;
  void refreshReleases(BuildContext context) {
    if (context.read<ReadarrState>().enabled) {
      if (bookId != null) {
        _releases =
            context.read<ReadarrState>().api!.release.get(bookId: bookId!);
      } else if (authorId != null) {
        _releases = context
            .read<ReadarrState>()
            .api!
            .release
            .getAuthorPack(authorId: authorId!)
            .then((releases) => releases.toList());
      } else {
        throw Exception('Must supply either bookId or authorId');
      }
    }
    notifyListeners();
  }

  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  set searchQuery(String searchQuery) {
    _searchQuery = searchQuery;
    notifyListeners();
  }

  ReadarrReleasesFilter? _filterType =
      ReadarrDatabaseValue.DEFAULT_FILTERING_RELEASES.data;
  ReadarrReleasesFilter get filterType => _filterType!;
  set filterType(ReadarrReleasesFilter filterType) {
    _filterType = filterType;
    notifyListeners();
  }

  ReadarrReleasesSorting? _sortType =
      ReadarrDatabaseValue.DEFAULT_SORTING_RELEASES.data;
  ReadarrReleasesSorting get sortType => _sortType!;
  set sortType(ReadarrReleasesSorting sortType) {
    _sortType = sortType;
    notifyListeners();
  }

  bool? _sortAscending =
      ReadarrDatabaseValue.DEFAULT_SORTING_RELEASES_ASCENDING.data;
  bool get sortAscending => _sortAscending!;
  set sortAscending(bool sortAscending) {
    _sortAscending = sortAscending;
    notifyListeners();
  }
}
