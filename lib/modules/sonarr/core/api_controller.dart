import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAPIController {
  Future<bool> addTag({
    @required BuildContext context,
    @required String label,
    bool showSnackbar = true,
  }) async {
    assert(label != null);
    if (context.read<SonarrState>().enabled) {
      return await context
          .read<SonarrState>()
          .api
          .tag
          .create(label: label)
          .then((tag) {
        showLunaSuccessSnackBar(
          title: 'sonarr.AddedTag'.tr(),
          message: tag.label,
        );
        return true;
      }).catchError((error, stack) {
        LunaLogger().error('Failed to add tag: $label', error, stack);
        if (showSnackbar)
          showLunaErrorSnackBar(
            title: 'sonarr.FailedToAddTag'.tr(),
            error: error,
          );
        return false;
      });
    }
    return false;
  }
}
