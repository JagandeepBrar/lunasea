import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesEditTagsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'sonarr.Tags'.tr()),
      subtitle: LunaText.subtitle(
        text: (context.watch<SonarrSeriesEditState>().tags?.isEmpty ?? true)
            ? 'lunasea.NotSet'.tr()
            : context
                .watch<SonarrSeriesEditState>()
                .tags
                .map((e) => e.label)
                .join(', '),
      ),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async => await SonarrDialogs().setEditTags(context),
    );
  }
}
