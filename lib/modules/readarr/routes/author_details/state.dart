import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorDetailsState extends ChangeNotifier {
  final ReadarrAuthor author;
  final List<ReadarrBook> books;

  ReadarrAuthorDetailsState({
    required BuildContext context,
    required this.author,
    required this.books,
  }) {
    fetchHistory(context);
  }

  Future<void> fetchHistory(BuildContext context) async {
    ReadarrState state = context.read<ReadarrState>();
    if (state.enabled) {
      _history = state.api!.history.getByAuthor(
        authorId: author.id!,
        includeBook: true,
      );
    }
    notifyListeners();
    await _history;
  }

  Future<List<ReadarrHistoryRecord>>? _history;
  Future<List<ReadarrHistoryRecord>>? get history => _history;
}
