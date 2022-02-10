import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrEditSeriesActionBar extends StatelessWidget {
  const ReadarrEditSeriesActionBar({
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
          loadingState: context.watch<ReadarrAuthorEditState>().state,
          onTap: () async => _updateOnTap(context),
        ),
      ],
    );
  }

  Future<void> _updateOnTap(BuildContext context) async {
    if (context.read<ReadarrAuthorEditState>().canExecuteAction) {
      context.read<ReadarrAuthorEditState>().state = LunaLoadingState.ACTIVE;
      if (context.read<ReadarrAuthorEditState>().series != null) {
        ReadarrAuthor series = context
            .read<ReadarrAuthorEditState>()
            .series!
            .updateEdits(context.read<ReadarrAuthorEditState>());
        bool result = await ReadarrAPIController().updateAuthor(
          context: context,
          series: series,
        );
        if (result) Navigator.of(context).lunaSafetyPop();
      }
    }
  }
}
