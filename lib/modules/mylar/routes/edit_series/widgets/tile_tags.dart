import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesEditTagsTile extends StatelessWidget {
  const MylarSeriesEditTagsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'mylar.Tags'.tr(),
      body: [
        TextSpan(
          text: (context.watch<MylarSeriesEditState>().tags?.isEmpty ?? true)
              ? 'lunasea.NotSet'.tr()
              : context
                  .watch<MylarSeriesEditState>()
                  .tags
                  ?.map((e) => e.label)
                  .join(', '),
        )
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => await MylarDialogs().setEditTags(context),
    );
  }
}
