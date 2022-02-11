import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorEditSeriesPathTile extends StatelessWidget {
  const ReadarrAuthorEditSeriesPathTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'readarr.AuthorPath'.tr(),
      body: [
        TextSpan(
          text: context.watch<ReadarrAuthorEditState>().seriesPath,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    Tuple2<bool, String> _values = await LunaDialogs().editText(
      context,
      'readarr.AuthorPath'.tr(),
      prefill: context.read<ReadarrAuthorEditState>().seriesPath,
    );
    if (_values.item1)
      context.read<ReadarrAuthorEditState>().seriesPath = _values.item2;
  }
}
