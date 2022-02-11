import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

enum ReadarrBookSettingsType {
  AUTOMATIC_SEARCH,
  INTERACTIVE_SEARCH,
  REFRESH,
  DELETE,
  MONITORED,
}

extension ReadarrEpisodeSettingsTypeExtension on ReadarrBookSettingsType {
  IconData icon(ReadarrBook book) {
    switch (this) {
      case ReadarrBookSettingsType.MONITORED:
        return book.monitored!
            ? Icons.turned_in_not_rounded
            : Icons.turned_in_rounded;
      case ReadarrBookSettingsType.AUTOMATIC_SEARCH:
        return Icons.search_rounded;
      case ReadarrBookSettingsType.INTERACTIVE_SEARCH:
        return Icons.youtube_searched_for_rounded;
      case ReadarrBookSettingsType.REFRESH:
        return Icons.refresh_rounded;
      case ReadarrBookSettingsType.DELETE:
        return Icons.delete_rounded;
    }
  }

  String name(ReadarrBook book) {
    switch (this) {
      case ReadarrBookSettingsType.MONITORED:
        return book.monitored!
            ? 'readarr.UnmonitorBook'.tr()
            : 'readarr.MonitorBook'.tr();
      case ReadarrBookSettingsType.AUTOMATIC_SEARCH:
        return 'readarr.AutomaticSearch'.tr();
      case ReadarrBookSettingsType.INTERACTIVE_SEARCH:
        return 'readarr.InteractiveSearch'.tr();
      case ReadarrBookSettingsType.REFRESH:
        return 'readarr.RefreshBook'.tr();
      case ReadarrBookSettingsType.DELETE:
        return 'readarr.RemoveBook'.tr();
    }
  }

  Future<void> execute(
    BuildContext context,
    ReadarrBook book,
  ) async {
    switch (this) {
      case ReadarrBookSettingsType.MONITORED:
        await ReadarrAPIController().toggleBookMonitored(
          context: context,
          book: book,
        );
        break;
      case ReadarrBookSettingsType.AUTOMATIC_SEARCH:
        await ReadarrAPIController().bookSearch(
          context: context,
          book: book,
        );
        break;
      case ReadarrBookSettingsType.INTERACTIVE_SEARCH:
        await ReadarrReleasesRouter().navigateTo(
          context,
          bookId: book.id,
        );
        break;
      case ReadarrBookSettingsType.REFRESH:
        await ReadarrAPIController().refreshBook(
          context: context,
          book: book,
        );
        break;
      case ReadarrBookSettingsType.DELETE:
        bool result = await ReadarrDialogs().removeBook(context);
        if (result) {
          await ReadarrAPIController()
              .removeBook(context: context, book: book)
              .then((_) => Navigator.of(context).lunaSafetyPop());
        }
        break;
    }
  }
}
