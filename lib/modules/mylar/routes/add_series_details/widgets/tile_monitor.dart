import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesAddDetailsMonitorTile extends StatelessWidget {
  const MylarSeriesAddDetailsMonitorTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'mylar.Monitor'.tr(),
      body: [
        TextSpan(
          text:
              context.watch<MylarSeriesAddDetailsState>().monitorType.lunaName,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    Tuple2<bool, MylarSeriesMonitorType?> result =
        await MylarDialogs().editMonitorType(context);
    if (result.item1) {
      context.read<MylarSeriesAddDetailsState>().monitorType = result.item2!;
      MylarDatabase.ADD_SERIES_DEFAULT_MONITOR_TYPE
          .update(result.item2!.value!);
    }
  }
}
