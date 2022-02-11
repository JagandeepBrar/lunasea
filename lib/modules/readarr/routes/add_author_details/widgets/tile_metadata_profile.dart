import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorAddDetailsMetadataProfileTile extends StatelessWidget {
  const ReadarrAuthorAddDetailsMetadataProfileTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'readarr.MetadataProfile'.tr(),
      body: [
        TextSpan(
          text: context
                  .watch<ReadarrAuthorAddDetailsState>()
                  .metadataProfile
                  .name ??
              LunaUI.TEXT_EMDASH,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    List<ReadarrMetadataProfile> _profiles =
        await context.read<ReadarrState>().metadataProfiles!;
    Tuple2<bool, ReadarrMetadataProfile?> result =
        await ReadarrDialogs().editMetadataProfiles(context, _profiles);
    if (result.item1) {
      context.read<ReadarrAuthorAddDetailsState>().metadataProfile =
          result.item2!;
      ReadarrDatabaseValue.ADD_SERIES_DEFAULT_LANGUAGE_PROFILE
          .put(result.item2!.id);
    }
  }
}
