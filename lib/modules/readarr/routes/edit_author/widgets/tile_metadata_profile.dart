import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorEditMetadataProfileTile extends StatelessWidget {
  final List<ReadarrMetadataProfile?> profiles;

  const ReadarrAuthorEditMetadataProfileTile({
    Key? key,
    required this.profiles,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'readarr.MetadataProfile'.tr(),
      body: [
        TextSpan(
          text: context.watch<ReadarrAuthorEditState>().metadataProfile.name,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    Tuple2<bool, ReadarrMetadataProfile?> result =
        await ReadarrDialogs().editMetadataProfiles(context, profiles);
    if (result.item1)
      context.read<ReadarrAuthorEditState>().metadataProfile = result.item2!;
  }
}
