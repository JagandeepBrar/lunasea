import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesAddDetailsTagsTile extends StatelessWidget {
  const MylarSeriesAddDetailsTagsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MylarTag> _tags = context.watch<MylarSeriesAddDetailsState>().tags;
    return LunaBlock(
      title: 'mylar.Tags'.tr(),
      body: [
        TextSpan(
          text: _tags.isEmpty
              ? LunaUI.TEXT_EMDASH
              : _tags.map((e) => e.label).join(', '),
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => await MylarDialogs().setAddTags(context),
    );
  }
}
