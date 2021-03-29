import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrBottomModalSheets {
    Future<void> configureManualImport(BuildContext context) async {
        await LunaBottomModalSheet().showModal(
            context: context,
            expand: false,
            builder: (_) => ChangeNotifierProvider.value(
                value: context.read<RadarrManualImportDetailsTileState>(),
                builder: (context, _) => LunaListViewModal(
                    children: [
                        LunaHeader(
                            text: 'radarr.Configure'.tr(),
                            subtitle: context.read<RadarrManualImportDetailsTileState>().manualImport.relativePath,
                        ),
                        LunaListTile(
                            context: context,
                            title: LunaText.title(text: 'radarr.SelectMovie'.tr()),
                            subtitle: LunaText.subtitle(text: context.watch<RadarrManualImportDetailsTileState>().manualImport.lunaMovie),
                            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
                            onTap: () async {
                                //TODO
                            },
                        ),
                        LunaListTile(
                            context: context,
                            title: LunaText.title(text: 'radarr.SelectQuality'.tr()),
                            subtitle: LunaText.subtitle(text: context.watch<RadarrManualImportDetailsTileState>().manualImport.lunaQualityProfile),
                            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
                            onTap: () async {
                                List<RadarrQualityDefinition> profiles = await context.read<RadarrState>().qualityDefinitions;
                                Tuple2<bool, RadarrQualityDefinition> result = await RadarrDialogs().selectQualityDefinition(context, profiles);
                                if(result.item1) context.read<RadarrManualImportDetailsTileState>().updateQuality(result.item2.quality);
                            },
                        ),
                        LunaListTile(
                            context: context,
                            title: LunaText.title(text: 'radarr.SelectLanguage'.tr()),
                            subtitle: LunaText.subtitle(text: context.watch<RadarrManualImportDetailsTileState>().manualImport.lunaLanguage),
                            trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
                            onTap: () async {
                                List<RadarrLanguage> languages = await context.read<RadarrState>().languages;
                                await RadarrDialogs().setManualImportLanguages(context, languages);
                            },
                        ),
                    ],
                ),
            ),
        );
    }
}
