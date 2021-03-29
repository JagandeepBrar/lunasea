import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrBottomModalSheets {
    Future<void> configureManualImport(BuildContext context, RadarrManualImport import) async {
        await LunaBottomModalSheet().showModal(
            context: context,
            expand: false,
            builder: (context) => LunaListViewModal(
                children: [
                    LunaHeader(
                        text: 'radarr.Configure'.tr(),
                        subtitle: import.relativePath,
                    ),
                    LunaListTile(
                        context: context,
                        title: LunaText.title(text: 'radarr.SelectMovie'.tr()),
                        subtitle: LunaText.subtitle(text: import.lunaMovie),
                        trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
                    ),
                    LunaListTile(
                        context: context,
                        title: LunaText.title(text: 'radarr.SelectQuality'.tr()),
                        subtitle: LunaText.subtitle(text: import.lunaQualityProfile),
                        trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
                    ),
                    LunaListTile(
                        context: context,
                        title: LunaText.title(text: 'radarr.SelectLanguage'.tr()),
                        subtitle: LunaText.subtitle(text: import.lunaLanguage),
                        trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
                    ),
                ],
            ),
        );
    }
}
