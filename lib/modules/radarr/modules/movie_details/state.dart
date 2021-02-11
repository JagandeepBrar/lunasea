import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsState extends ChangeNotifier {
    final RadarrMovie movie;

    RadarrMovieDetailsState({
        @required BuildContext context,
        @required this.movie,
    }) {
        assert(context != null);
        assert(movie != null);
        fetchFiles(context);
    }


    Future<void> fetchFiles(BuildContext context) async {
        RadarrState state = context.read<RadarrState>();
        if(state.enabled) {
            _extraFiles = state.api.extraFile.get(movieId: movie.id);
            _movieFiles = state.api.movieFile.get(movieId: movie.id);
        }
        notifyListeners();
        await Future.wait([
            _extraFiles,
            _movieFiles,
        ]);
    }

    Future<List<RadarrExtraFile>> _extraFiles;
    Future<List<RadarrExtraFile>> get extraFiles => _extraFiles;
    Future<List<RadarrMovieFile>> _movieFiles;
    Future<List<RadarrMovieFile>> get movieFiles => _movieFiles;
}