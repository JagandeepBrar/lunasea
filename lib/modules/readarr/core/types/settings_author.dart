import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

enum ReadarrAuthorSettingsType {
  EDIT,
  REFRESH,
  DELETE,
  MONITORED,
}

extension ReadarrAuthorSettingsTypeExtension on ReadarrAuthorSettingsType {
  IconData icon(ReadarrAuthor series) {
    switch (this) {
      case ReadarrAuthorSettingsType.MONITORED:
        return series.monitored!
            ? Icons.turned_in_not_rounded
            : Icons.turned_in_rounded;
      case ReadarrAuthorSettingsType.EDIT:
        return Icons.edit_rounded;
      case ReadarrAuthorSettingsType.REFRESH:
        return Icons.refresh_rounded;
      case ReadarrAuthorSettingsType.DELETE:
        return Icons.delete_rounded;
    }
  }

  String name(ReadarrAuthor series) {
    switch (this) {
      case ReadarrAuthorSettingsType.MONITORED:
        return series.monitored!
            ? 'readarr.UnmonitorAuthor'.tr()
            : 'readarr.MonitorAuthor'.tr();
      case ReadarrAuthorSettingsType.EDIT:
        return 'readarr.EditAuthor'.tr();
      case ReadarrAuthorSettingsType.REFRESH:
        return 'readarr.RefreshAuthor'.tr();
      case ReadarrAuthorSettingsType.DELETE:
        return 'readarr.RemoveAuthor'.tr();
    }
  }

  Future<void> execute(BuildContext context, ReadarrAuthor series) async {
    switch (this) {
      case ReadarrAuthorSettingsType.EDIT:
        await ReadarrEditAuthorRouter().navigateTo(context, series.id!);
        break;
      case ReadarrAuthorSettingsType.REFRESH:
        await ReadarrAPIController().refreshAuthor(
          context: context,
          series: series,
        );
        break;
      case ReadarrAuthorSettingsType.DELETE:
        bool result = await ReadarrDialogs().removeAuthor(context);
        if (result) {
          await ReadarrAPIController()
              .removeAuthor(context: context, author: series)
              .then((_) => Navigator.of(context).lunaSafetyPop());
        }
        break;
      case ReadarrAuthorSettingsType.MONITORED:
        await ReadarrAPIController().toggleAuthorMonitored(
          context: context,
          author: series,
        );
        break;
    }
  }
}
