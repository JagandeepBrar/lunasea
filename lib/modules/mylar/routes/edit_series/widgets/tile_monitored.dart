import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesEditMonitoredTile extends StatelessWidget {
  const MylarSeriesEditMonitoredTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'mylar.Monitored'.tr(),
      trailing: LunaSwitch(
        value: context.watch<MylarSeriesEditState>().monitored,
        onChanged: (value) =>
            context.read<MylarSeriesEditState>().monitored = value,
      ),
    );
  }
}
