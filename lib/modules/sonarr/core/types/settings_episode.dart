import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

enum SonarrEpisodeSettingsType {
  MONITORED,
  AUTOMATIC_SEARCH,
  INTERACTIVE_SEARCH,
  DELETE_FILE,
}

extension SonarrEpisodeSettingsTypeExtension on SonarrEpisodeSettingsType {
  IconData icon(SonarrEpisode episode) {
    switch (this) {
      case SonarrEpisodeSettingsType.MONITORED:
        return episode.monitored ? Icons.turned_in_not : Icons.turned_in;
      case SonarrEpisodeSettingsType.AUTOMATIC_SEARCH:
        return Icons.search;
      case SonarrEpisodeSettingsType.INTERACTIVE_SEARCH:
        return Icons.youtube_searched_for;
      case SonarrEpisodeSettingsType.DELETE_FILE:
        return Icons.delete;
    }
    throw Exception('Invalid SonarrEpisodeSettingsType');
  }

  String name(SonarrEpisode episode) {
    switch (this) {
      case SonarrEpisodeSettingsType.MONITORED:
        return episode.monitored
            ? 'sonarr.UnmonitorEpisode'.tr()
            : 'sonarr.MonitorEpisode'.tr();
      case SonarrEpisodeSettingsType.AUTOMATIC_SEARCH:
        return 'sonarr.AutomaticSearch'.tr();
      case SonarrEpisodeSettingsType.INTERACTIVE_SEARCH:
        return 'sonarr.InteractiveSearch'.tr();
      case SonarrEpisodeSettingsType.DELETE_FILE:
        return 'sonarr.DeleteFile'.tr();
    }
    throw Exception('Invalid SonarrEpisodeSettingsType');
  }

  Future<void> execute({
    @required BuildContext context,
    @required SonarrEpisode episode,
    @required SonarrEpisodeFile episodeFile,
  }) async {
    switch (this) {
      case SonarrEpisodeSettingsType.MONITORED:
        return SonarrAPIController().toggleEpisodeMonitored(
          context: context,
          episode: episode,
        );
      case SonarrEpisodeSettingsType.AUTOMATIC_SEARCH:
        return SonarrAPIController().episodeSearch(
          context: context,
          episode: episode,
        );
      case SonarrEpisodeSettingsType.INTERACTIVE_SEARCH:
        return SonarrReleasesRouter().navigateTo(
          context,
          episodeId: episode.id,
        );
      case SonarrEpisodeSettingsType.DELETE_FILE:
        return SonarrAPIController().deleteEpisode(
          context: context,
          episodeFile: episodeFile,
        );
    }
    throw Exception('Invalid SonarrEpisodeSettingsType');
  }
}
