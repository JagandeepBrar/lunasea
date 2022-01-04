import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsState extends ChangeNotifier {
  final RadarrMovie movie;
  late Future<List<RadarrHistoryRecord>> history;
  late Future<List<RadarrMovieCredits>> credits;
  late Future<List<RadarrExtraFile>> extraFiles;
  late Future<List<RadarrMovieFile>> movieFiles;

  RadarrMovieDetailsState({
    required BuildContext context,
    required this.movie,
  }) {
    fetchFiles(context);
    fetchCredits(context);
    fetchHistory(context);
  }

  Future<void> fetchHistory(BuildContext context) async {
    RadarrState state = context.read<RadarrState>();
    if (state.enabled) {
      history = state.api!.history.getForMovie(movieId: movie.id!);
    }
    notifyListeners();
    await history;
  }

  Future<void> fetchCredits(BuildContext context) async {
    RadarrState state = context.read<RadarrState>();
    if (state.enabled) {
      credits = state.api!.credits.get(movieId: movie.id!);
    }
    notifyListeners();
    await credits;
  }

  Future<void> fetchFiles(BuildContext context) async {
    RadarrState state = context.read<RadarrState>();
    if (state.enabled) {
      extraFiles = state.api!.extraFile.get(movieId: movie.id!);
      movieFiles = state.api!.movieFile.get(movieId: movie.id!);
    }
    notifyListeners();
    await Future.wait([
      extraFiles,
      movieFiles,
    ]);
  }
}
