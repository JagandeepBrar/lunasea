import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationAppearanceRouter extends LunaPageRouter {
    SettingsConfigurationAppearanceRouter() : super('/settings/configuration/appearance');
    
    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationAppearanceRoute());
}

class _SettingsConfigurationAppearanceRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationAppearanceRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationAppearanceRoute> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Appearance',
            state: context.read<SettingsState>(),
        );
    }

    Widget _body() {
        return LunaListView(
            scrollController: context.read<SettingsState>().scrollController,
            children: [
                _amoledTheme(),
                _amoledThemeBorders(),
                _imageBackgroundOpacity(),
                _use24HourTime(),
            ],
        );
    }

    Widget _amoledTheme() {
        return LunaDatabaseValue.THEME_AMOLED.listen(
            builder: (context, _, __) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'AMOLED Dark Theme'),
                subtitle: LunaText.subtitle(text: 'Pure Black Dark Theme'),
                trailing: LunaSwitch(
                    value: LunaDatabaseValue.THEME_AMOLED.data,
                    onChanged: (value) => LunaDatabaseValue.THEME_AMOLED.put(value),
                ),
            ),
        );
    }

    Widget _amoledThemeBorders() {
        return ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [LunaDatabaseValue.THEME_AMOLED_BORDER.key, LunaDatabaseValue.THEME_AMOLED.key]),
            builder: (context, _, __) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'AMOLED Borders'),
                subtitle: LunaText.subtitle(text: 'Add Subtle Borders Across the UI'),
                trailing: LunaSwitch(
                    value: LunaDatabaseValue.THEME_AMOLED_BORDER.data,
                    onChanged: LunaDatabaseValue.THEME_AMOLED.data ? (value) => LunaDatabaseValue.THEME_AMOLED_BORDER.put(value) : null,
                ),
            ),
        );
    }

    Widget _imageBackgroundOpacity() {
        return LunaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.listen(
            builder: (context, _, __) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Background Image Opacity'),
                subtitle: LunaText.subtitle(text: LunaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.data == 0
                    ? 'Disabled'
                    : '${LunaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.data}%'
                ),
                trailing: LunaIconButton(icon: Icons.arrow_forward_ios),
                onTap: () async {
                    Tuple2<bool, int> result = await SettingsDialogs().changeBackgroundImageOpacity(context);
                    if(result.item1) LunaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.put(result.item2);
                },
            ),
        );
    }

    Widget _use24HourTime() {
        return LunaDatabaseValue.USE_24_HOUR_TIME.listen(
            builder: (context, _, __) => LunaListTile(
                context: context,
                title: LunaText.title(text: 'Use 24 Hour Time'),
                subtitle: LunaText.subtitle(text: 'Show Timestamps in 24 Hour Style'),
                trailing: LunaSwitch(
                    value: LunaDatabaseValue.USE_24_HOUR_TIME.data,
                    onChanged: (value) => LunaDatabaseValue.USE_24_HOUR_TIME.put(value),
                ),
            ),
        );
    }
}
