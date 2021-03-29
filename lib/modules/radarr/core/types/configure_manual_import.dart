import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

enum RadarrManualImportConfigure {
    MOVIE,
    QUALITY_PROFILE,
    LANGUAGE,
}

extension RadarrManualImportConfigureExtension on RadarrManualImportConfigure {
    IconData get icon {
        switch(this) {
            case RadarrManualImportConfigure.MOVIE: return LunaIcons.movies;
            case RadarrManualImportConfigure.QUALITY_PROFILE: return Icons.portrait_rounded;
            case RadarrManualImportConfigure.LANGUAGE: return Icons.translate_rounded;
        }
        throw Exception('Invalid RadarrManualImportConfigure');
    }

    String get name {
        switch(this) {
            case RadarrManualImportConfigure.MOVIE: return 'radarr.Movie'.tr();
            case RadarrManualImportConfigure.QUALITY_PROFILE: return 'radarr.QualityProfile'.tr();
            case RadarrManualImportConfigure.LANGUAGE: return 'radarr.Language'.tr();
        }
        throw Exception('Invalid RadarrManualImportConfigure');
    }
}
