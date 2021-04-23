import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliAppBarGlobalSettingsAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LunaIconButton(
      icon: Icons.more_vert,
      onPressed: () async {
        Tuple2<bool, TautulliGlobalSettingsType> values =
            await TautulliDialogs().globalSettings(context);
        if (values.item1) values.item2.execute(context);
      },
    );
  }
}
