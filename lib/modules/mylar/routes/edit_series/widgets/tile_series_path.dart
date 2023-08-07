import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesEditSeriesPathTile extends StatelessWidget {
  const MylarSeriesEditSeriesPathTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'mylar.SeriesPath'.tr(),
      body: [
        TextSpan(
          text: context.watch<MylarSeriesEditState>().seriesPath,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    Tuple2<bool, String> _values = await LunaDialogs().editText(
      context,
      'mylar.SeriesPath'.tr(),
      prefill: context.read<MylarSeriesEditState>().seriesPath,
    );
    if (_values.item1)
      context.read<MylarSeriesEditState>().seriesPath = _values.item2;
  }
}
