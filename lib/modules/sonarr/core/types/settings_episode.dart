import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:lunasea/router/routes/sonarr.dart';

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
        return episode.monitored!
            ? Icons.turned_in_not_rounded
            : Icons.turned_in_rounded;
      case SonarrEpisodeSettingsType.AUTOMATIC_SEARCH:
        return Icons.search_rounded;
      case SonarrEpisodeSettingsType.INTERACTIVE_SEARCH:
        return Icons.youtube_searched_for_rounded;
      case SonarrEpisodeSettingsType.DELETE_FILE:
        return Icons.delete_rounded;
    }
  }

  String name(SonarrEpisode episode) {
    switch (this) {
      case SonarrEpisodeSettingsType.MONITORED:
        return episode.monitored!
            ? 'sonarr.UnmonitorEpisode'.tr()
            : 'sonarr.MonitorEpisode'.tr();
      case SonarrEpisodeSettingsType.AUTOMATIC_SEARCH:
        return 'sonarr.AutomaticSearch'.tr();
      case SonarrEpisodeSettingsType.INTERACTIVE_SEARCH:
        return 'sonarr.InteractiveSearch'.tr();
      case SonarrEpisodeSettingsType.DELETE_FILE:
        return 'sonarr.DeleteFile'.tr();
    }
  }

  Future<void> execute({
    required BuildContext context,
    required SonarrEpisode episode,
    required SonarrEpisodeFile? episodeFile,
  }) async {
    switch (this) {
      case SonarrEpisodeSettingsType.MONITORED:
        await SonarrAPIController().toggleEpisodeMonitored(
          context: context,
          episode: episode,
        );
        break;
      case SonarrEpisodeSettingsType.AUTOMATIC_SEARCH:
        await SonarrAPIController().episodeSearch(
          context: context,
          episode: episode,
        );
        break;
      case SonarrEpisodeSettingsType.INTERACTIVE_SEARCH:
        SonarrRoutes.RELEASES.go(queryParams: {
          'episode': episode.id.toString(),
        });
        break;
      case SonarrEpisodeSettingsType.DELETE_FILE:
        bool result = await SonarrDialogs().deleteEpisode(context);
        if (result) {
          await SonarrAPIController()
              .deleteEpisode(
            context: context,
            episode: episode,
            episodeFile: episodeFile!,
          )
              .then((_) {
            context.read<SonarrSeasonDetailsState>().fetchHistory(context);
            context
                .read<SonarrSeasonDetailsState>()
                .fetchEpisodeHistory(context, episode.id);
          });
        }
        break;
    }
  }
}
