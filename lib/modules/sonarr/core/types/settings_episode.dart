import 'package:flutter/material.dart';
import 'package:lunasea/modules/sonarr.dart';

enum SonarrEpisodeSettingsType {
    MONITORED,
    AUTOMATIC_SEARCH,
    INTERACTIVE_SEARCH,
    DELETE_FILE,
}

extension SonarrEpisodeSettingsTypeExtension on SonarrEpisodeSettingsType {
    IconData icon(SonarrEpisode episode) {
        switch(this) {
            case SonarrEpisodeSettingsType.MONITORED: return episode.monitored ? Icons.turned_in_not : Icons.turned_in;
            case SonarrEpisodeSettingsType.AUTOMATIC_SEARCH: return Icons.search;
            case SonarrEpisodeSettingsType.INTERACTIVE_SEARCH: return Icons.youtube_searched_for;
            case SonarrEpisodeSettingsType.DELETE_FILE: return Icons.delete;
        }
        throw Exception('Invalid SonarrEpisodeSettingsType');
    }

    String name(SonarrEpisode episode) {
        switch(this) {
            case SonarrEpisodeSettingsType.MONITORED: return episode.monitored ? 'Unmonitor Episode' : 'Monitor Episode';
            case SonarrEpisodeSettingsType.AUTOMATIC_SEARCH: return 'Automatic Search';
            case SonarrEpisodeSettingsType.INTERACTIVE_SEARCH: return 'Interactive Search';
            case SonarrEpisodeSettingsType.DELETE_FILE: return 'Delete File';
        }
        throw Exception('Invalid SonarrEpisodeSettingsType');
    }
}
