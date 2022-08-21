import 'package:flutter/material.dart';
import 'package:lunasea/vendor.dart';
import 'package:lunasea/widgets/ui.dart';

class DatabaseCorruptionSheet extends LunaBottomModalSheet {
  @override
  Widget builder(BuildContext context) {
    return LunaListViewModal(
      children: [
        LunaHeader(
          text: 'settings.DatabaseCorruptionDetected'.tr(),
          subtitle: [
            'settings.DatabaseCorruptionDetectedMessageLine1'.tr(),
            'settings.DatabaseCorruptionDetectedMessageLine2'.tr(),
          ].join('\n\n'),
        ),
      ],
    );
  }
}
