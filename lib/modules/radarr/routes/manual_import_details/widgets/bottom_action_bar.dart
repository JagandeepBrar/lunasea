import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrManualImportDetailsBottomActionBar extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return LunaBottomActionBar(
            actions: [
                LunaButton(
                    type: LunaButtonType.TEXT,
                    text: 'radarr.Import'.tr(args: ['radarr.Move'.tr()]),
                    backgroundColor: LunaColours.primary,
                    onTap: () async => _importOnTap(context, false),
                ),
                LunaButton(
                    type: LunaButtonType.TEXT,
                    text: 'radarr.Import'.tr(args: ['radarr.Copy'.tr()]),
                    backgroundColor: LunaColours.primary,
                    onTap: () async => _importOnTap(context, true),
                )
            ],
        );
    }

    Future<void> _importOnTap(BuildContext context, bool isCopy) async {
        if(context.read<RadarrManualImportDetailsState>().canExecuteAction) {
            print('yes');
        }
    }
}
