import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrBottomModalSheets {
    Future<void> configureManualImport(BuildContext context, RadarrManualImport import) async {
        await LunaBottomModalSheet().showModal(
            context: context,
            expand: false,
            builder: (context) => SafeArea(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        LunaHeader(
                            text: 'radarr.ManualImport'.tr(),
                            subtitle: import.relativePath,
                        ),
                        LunaListTile(
                            context: context,
                            title: LunaText.title(text: 'radarr.SelectMovie'.tr()),
                            subtitle: LunaText.subtitle(text: 'radarr.SelectMovieDescription'.tr()),
                            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
                        ),
                        LunaListTile(
                            context: context,
                            title: LunaText.title(text: 'radarr.SelectQuality'.tr()),
                            subtitle: LunaText.subtitle(text: 'radarr.SelectQualityDescription'.tr()),
                            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
                        ),
                        LunaListTile(
                            context: context,
                            title: LunaText.title(text: 'radarr.SelectLanguage'.tr()),
                            subtitle: LunaText.subtitle(text: 'radarr.SelectLanguageDescription'.tr()),
                            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
                        ),
                    ],
                ),
            ),
        );
    }
}
