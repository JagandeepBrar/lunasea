import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAppBarGlobalSettingsAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LunaIconButton(
      icon: Icons.more_vert,
      onPressed: () async {
        Tuple2<bool, SonarrGlobalSettingsType> values =
            await SonarrDialogs().globalSettings(context);
        if (values.item1) values.item2.execute(context);
      },
    );
  }
}
