import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';
import 'package:lunasea/router/routes/sonarr.dart';

enum SonarrSeasonSettingsType {
  AUTOMATIC_SEARCH,
  INTERACTIVE_SEARCH,
}

extension SonarrSeasonSettingsTypeExtension on SonarrSeasonSettingsType {
  IconData get icon {
    switch (this) {
      case SonarrSeasonSettingsType.AUTOMATIC_SEARCH:
        return Icons.search_rounded;
      case SonarrSeasonSettingsType.INTERACTIVE_SEARCH:
        return Icons.youtube_searched_for_rounded;
    }
  }

  String get name {
    switch (this) {
      case SonarrSeasonSettingsType.AUTOMATIC_SEARCH:
        return 'sonarr.AutomaticSearch'.tr();
      case SonarrSeasonSettingsType.INTERACTIVE_SEARCH:
        return 'sonarr.InteractiveSearch'.tr();
    }
  }

  Future<void> execute(
    BuildContext context,
    int? seriesId,
    int? seasonNumber,
  ) async {
    switch (this) {
      case SonarrSeasonSettingsType.AUTOMATIC_SEARCH:
        await SonarrAPIController().automaticSeasonSearch(
          context: context,
          seriesId: seriesId,
          seasonNumber: seasonNumber,
        );
        return;
      case SonarrSeasonSettingsType.INTERACTIVE_SEARCH:
        return SonarrRoutes.RELEASES.go(queryParams: {
          'series': seriesId.toString(),
          'season': seasonNumber.toString(),
        });
    }
  }
}
