import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsCustomizationAppearanceBackgroundImageOpacityTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'Background Image Opacity'),
            subtitle: LSSubtitle(text: LunaSeaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.data == 0
                ? 'Disabled'
                : '${LunaSeaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.data}%'
            ),
            trailing: LSIconButton(icon: Icons.arrow_forward_ios),
            onTap: () async => _changeOpacity(context),
        ),
    );

    Future<void> _changeOpacity(BuildContext context) async {
        List _values = await SettingsDialogs.changeBackgroundImageOpacity(context);
        if(_values[0]) LunaSeaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.put(_values[1]);
    }
}
