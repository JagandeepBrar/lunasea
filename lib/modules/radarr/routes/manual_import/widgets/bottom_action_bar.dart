import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrManualImportBottomActionBar extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return LunaBottomActionBar(
            actions: [
                LunaButton.text(
                    text: 'radarr.Quick'.tr(),
                    icon: Icons.flight_takeoff_rounded,
                    onTap: () async {
                        String path = context.read<RadarrManualImportState>().currentPath;
                        RadarrAPIHelper().quickImport(context: context, path: path);
                    },
                ),
                LunaButton.text(
                    text: 'radarr.Interactive'.tr(),
                    icon: Icons.person_rounded,
                    onTap: () async {
                        String path = context.read<RadarrManualImportState>().currentPath;
                        RadarrManualImportDetailsRouter().navigateTo(
                            context,
                            path: (path ?? '').isNotEmpty ? path : '/',
                        );
                    },
                ),
            ],
        );
    }
}
