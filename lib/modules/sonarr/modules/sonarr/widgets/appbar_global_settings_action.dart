import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAppBarGlobalSettingsAction extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSIconButton(
        icon: Icons.more_vert,
        onPressed: () async => _handler(context),
    );

    Future<void> _handler(BuildContext context) async {
        List values = await SonarrDialogs.globalSettings(context);
        if(values[0]) switch(values[1] as SonarrGlobalSettingsType) {
            case SonarrGlobalSettingsType.WEB_GUI: _webGUI(context); break;
            default: LunaLogger.warning('SonarrGlobalSettings', '_handler', 'Unknown case: ${(values[1] as SonarrGlobalSettingsType)}');
        }
    }

    Future<void> _webGUI(BuildContext context) async => Provider.of<SonarrState>(context, listen: false).host.lsLinks_OpenLink();
}
