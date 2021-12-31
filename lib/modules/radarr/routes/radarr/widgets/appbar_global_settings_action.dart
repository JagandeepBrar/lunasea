import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAppBarGlobalSettingsAction extends StatelessWidget {
  const RadarrAppBarGlobalSettingsAction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaIconButton(
      icon: Icons.more_vert_rounded,
      iconSize: LunaUI.ICON_SIZE,
      onPressed: () async {
        Tuple2<bool, RadarrGlobalSettingsType?> values =
            await RadarrDialogs().globalSettings(context);
        if (values.item1) values.item2!.execute(context);
      },
    );
  }
}
