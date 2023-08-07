import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';
import 'package:lunasea/router/router.dart';

class MylarEditSeriesActionBar extends StatelessWidget {
  const MylarEditSeriesActionBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBottomActionBar(
      actions: [
        LunaButton(
          type: LunaButtonType.TEXT,
          text: 'lunasea.Update'.tr(),
          icon: Icons.edit_rounded,
          loadingState: context.watch<MylarSeriesEditState>().state,
          onTap: () async => _updateOnTap(context),
        ),
      ],
    );
  }

  Future<void> _updateOnTap(BuildContext context) async {
    if (context.read<MylarSeriesEditState>().canExecuteAction) {
      context.read<MylarSeriesEditState>().state = LunaLoadingState.ACTIVE;
      if (context.read<MylarSeriesEditState>().series != null) {
        MylarSeries series = context
            .read<MylarSeriesEditState>()
            .series!
            .updateEdits(context.read<MylarSeriesEditState>());
        bool result = await MylarAPIController().updateSeries(
          context: context,
          series: series,
        );
        if (result) LunaRouter().popSafely();
      }
    }
  }
}
