import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesEditTagsTile extends StatelessWidget {
  const SonarrSeriesEditTagsTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'sonarr.Tags'.tr(),
      body: [
        TextSpan(
          text: (context.watch<SonarrSeriesEditState>().tags?.isEmpty ?? true)
              ? 'lunasea.NotSet'.tr()
              : context
                  .watch<SonarrSeriesEditState>()
                  .tags
                  ?.map((e) => e.label)
                  .join(', '),
        )
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => await SonarrDialogs().setEditTags(context),
    );
  }
}
