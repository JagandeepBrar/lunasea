import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesAddDetailsSeriesTypeTile extends StatelessWidget {
  const MylarSeriesAddDetailsSeriesTypeTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'mylar.SeriesType'.tr(),
      body: [
        TextSpan(
          text: context
                  .watch<MylarSeriesAddDetailsState>()
                  .seriesType
                  .value
                  ?.toTitleCase() ??
              LunaUI.TEXT_EMDASH,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    Tuple2<bool, MylarSeriesType?> result =
        await MylarDialogs().editSeriesType(context);
    if (result.item1) {
      context.read<MylarSeriesAddDetailsState>().seriesType = result.item2!;
      MylarDatabase.ADD_SERIES_DEFAULT_SERIES_TYPE
          .update(result.item2!.value!);
    }
  }
}
