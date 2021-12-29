import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsState extends ChangeNotifier {
  final RadarrMovie movie;

  RadarrMovieDetailsState({
    required BuildContext context,
    required this.movie,
  }) {
    assert(context != null);
    assert(movie != null);
    fetchFiles(context);
    fetchCredits(context);
    fetchHistory(context);
  }

  Future<void> fetchHistory(BuildContext context) async {
    RadarrState state = context.read<RadarrState>();
    if (state.enabled!)
      _history = state.api!.history.getForMovie(movieId: movie.id!);
    notifyListeners();
    await _history;
  }

  Future<void> fetchCredits(BuildContext context) async {
    RadarrState state = context.read<RadarrState>();
    if (state.enabled!) _credits = state.api!.credits.get(movieId: movie.id!);
    notifyListeners();
    await _credits;
  }

  Future<void> fetchFiles(BuildContext context) async {
    RadarrState state = context.read<RadarrState>();
    if (state.enabled!) {
      _extraFiles = state.api!.extraFile.get(movieId: movie.id!);
      _movieFiles = state.api!.movieFile.get(movieId: movie.id!);
    }
    notifyListeners();
    await Future.wait([
      _extraFiles.then((value) => value!),
      _movieFiles.then((value) => value!),
    ]);
  }

  Future<List<RadarrHistoryRecord>>? _history;
  Future<List<RadarrHistoryRecord>>? get history => _history;

  Future<List<RadarrMovieCredits>>? _credits;
  Future<List<RadarrMovieCredits>>? get credits => _credits;

  Future<List<RadarrExtraFile>>? _extraFiles;
  Future<List<RadarrExtraFile>>? get extraFiles => _extraFiles;
  Future<List<RadarrMovieFile>>? _movieFiles;
  Future<List<RadarrMovieFile>>? get movieFiles => _movieFiles;
}
