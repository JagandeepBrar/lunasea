import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrManualImportDetailsBottomActionBar extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return LunaBottomActionBar(
            actions: [
                RadarrDatabaseValue.MANUAL_IMPORT_DEFAULT_MODE.listen(
                    builder: (context, _, __) => LunaActionBarCard(
                        title: 'radarr.ImportMode'.tr(),
                        subtitle: RadarrImportMode.COPY.from((RadarrDatabaseValue.MANUAL_IMPORT_DEFAULT_MODE.data)).lunaReadable,
                        icon: Icons.arrow_forward_ios_rounded,
                        //checkboxState: true,
                        onTap: () async => _importModeOnTap(context),
                    ),
                ),
                LunaButton(
                    type: LunaButtonType.TEXT,
                    text: 'radarr.Import'.tr(),
                    icon: Icons.download_done_rounded,
                    onTap: () async => _importOnTap(context),
                ),
            ],
        );
    }

    Future<void> _importModeOnTap(BuildContext context) async {
        Tuple2<bool, RadarrImportMode> result = await RadarrDialogs().setManualImportMode(context);
        if(result.item1) RadarrDatabaseValue.MANUAL_IMPORT_DEFAULT_MODE.put(result.item2);
    }

    Future<void> _importOnTap(BuildContext context) async {
        if(context.read<RadarrManualImportDetailsState>().canExecuteAction) {
            print('yes');
        }
    }
}
