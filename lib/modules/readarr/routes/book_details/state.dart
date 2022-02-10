import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrBookDetailsState extends ChangeNotifier {
  final ReadarrBook book;
  late Future<List<ReadarrHistoryRecord>> history;
  late Future<List<ReadarrBookFile>> movieFiles;

  ReadarrBookDetailsState({
    required BuildContext context,
    required this.book,
  }) {
    fetchFiles(context);
    fetchHistory(context);
  }

  Future<void> fetchHistory(BuildContext context) async {
    ReadarrState state = context.read<ReadarrState>();
    if (state.enabled) {
      history = state.api!.history
          .getByAuthor(authorId: book.authorId!, bookId: book.id!);
    }
    notifyListeners();
    await history;
  }

  Future<void> fetchFiles(BuildContext context) async {
    ReadarrState state = context.read<ReadarrState>();
    if (state.enabled) {
      movieFiles = state.api!.bookFile.get(bookId: book.id!);
    }
    notifyListeners();
    await Future.wait([
      movieFiles,
    ]);
  }
}
