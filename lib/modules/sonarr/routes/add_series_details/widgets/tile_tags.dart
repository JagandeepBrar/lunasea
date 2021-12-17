import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsTagsTile extends StatelessWidget {
  const SonarrSeriesAddDetailsTagsTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'sonarr.Tags'.tr(),
      body: [
        TextSpan(
          text: context.watch<SonarrSeriesAddDetailsState>().tags.isEmpty
              ? LunaUI.TEXT_EMDASH
              : context
                  .watch<SonarrSeriesAddDetailsState>()
                  .tags
                  .map((e) => e.label)
                  .join(', '),
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => await SonarrDialogs().setAddTags(context),
    );
  }
}
