import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorEditTagsTile extends StatelessWidget {
  const ReadarrAuthorEditTagsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'readarr.Tags'.tr(),
      body: [
        TextSpan(
          text: (context.watch<ReadarrAuthorEditState>().tags?.isEmpty ?? true)
              ? 'lunasea.NotSet'.tr()
              : context
                  .watch<ReadarrAuthorEditState>()
                  .tags
                  ?.map((e) => e.label)
                  .join(', '),
        )
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => await ReadarrDialogs().setEditTags(context),
    );
  }
}
