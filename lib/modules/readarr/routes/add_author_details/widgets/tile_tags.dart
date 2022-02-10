import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorAddDetailsTagsTile extends StatelessWidget {
  const ReadarrAuthorAddDetailsTagsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ReadarrTag> _tags = context.watch<ReadarrAuthorAddDetailsState>().tags;
    return LunaBlock(
      title: 'readarr.Tags'.tr(),
      body: [
        TextSpan(
          text: _tags.isEmpty
              ? LunaUI.TEXT_EMDASH
              : _tags.map((e) => e.label).join(', '),
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => await ReadarrDialogs().setAddTags(context),
    );
  }
}
