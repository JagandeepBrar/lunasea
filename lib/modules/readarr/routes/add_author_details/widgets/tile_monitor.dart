import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorAddDetailsMonitorTile extends StatelessWidget {
  const ReadarrAuthorAddDetailsMonitorTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'readarr.Monitor'.tr(),
      body: [
        TextSpan(
          text: context
              .watch<ReadarrAuthorAddDetailsState>()
              .monitorType
              .lunaName,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    Tuple2<bool, ReadarrAuthorMonitorType?> result =
        await ReadarrDialogs().editMonitorType(context);
    if (result.item1) {
      context.read<ReadarrAuthorAddDetailsState>().monitorType = result.item2!;
      ReadarrDatabaseValue.ADD_SERIES_DEFAULT_MONITOR_TYPE
          .put(result.item2!.value);
    }
  }
}
