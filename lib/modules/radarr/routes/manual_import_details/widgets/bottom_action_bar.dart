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
                    text: 'radarr.Import'.tr(),
                    icon: Icons.download_done_rounded,
                    onTap: () async => _importOnTap(context),
                ),
            ],
        );
    }

    Future<void> _importOnTap(BuildContext context) async {
        if(context.read<RadarrManualImportDetailsState>().canExecuteAction) {
            print('yes');
        }
    }
}
