import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorEditMonitoredTile extends StatelessWidget {
  const ReadarrAuthorEditMonitoredTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'readarr.Monitored'.tr(),
      trailing: LunaSwitch(
        value: context.watch<ReadarrAuthorEditState>().monitored,
        onChanged: (value) =>
            context.read<ReadarrAuthorEditState>().monitored = value,
      ),
    );
  }
}
