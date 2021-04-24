import 'package:flutter/material.dart';

enum SonarrSeasonSettingsType {
  AUTOMATIC_SEARCH,
  INTERACTIVE_SEARCH,
}

extension SonarrSeasonSettingsTypeExtension on SonarrSeasonSettingsType {
  IconData get icon {
    switch (this) {
      case SonarrSeasonSettingsType.AUTOMATIC_SEARCH:
        return Icons.search;
      case SonarrSeasonSettingsType.INTERACTIVE_SEARCH:
        return Icons.youtube_searched_for;
    }
    throw Exception('Invalid SonarrSeasonSettingsType');
  }

  String get name {
    switch (this) {
      case SonarrSeasonSettingsType.AUTOMATIC_SEARCH:
        return 'Automatic Search';
      case SonarrSeasonSettingsType.INTERACTIVE_SEARCH:
        return 'Interactive Search';
    }
    throw Exception('Invalid SonarrSeasonSettingsType');
  }
}
