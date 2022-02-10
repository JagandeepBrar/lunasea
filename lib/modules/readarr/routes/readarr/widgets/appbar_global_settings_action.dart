import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAppBarGlobalSettingsAction extends StatelessWidget {
  const ReadarrAppBarGlobalSettingsAction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaIconButton(
      icon: Icons.more_vert_rounded,
      onPressed: () async {
        Tuple2<bool, ReadarrGlobalSettingsType?> values =
            await ReadarrDialogs().globalSettings(context);
        if (values.item1) values.item2!.execute(context);
      },
    );
  }
}
