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
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        body: _body,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: 'Appearance',
    );

    Widget get _body => LSListView(
        children: [
            _amoledThemeTile,
            _amoledThemeBordersTile,
            _imageBackgroundOpacityTile,
            _use24HourTime,
        ],
    );

    Widget get _amoledThemeTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaDatabaseValue.THEME_AMOLED.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'AMOLED Dark Theme'),
            subtitle: LSSubtitle(text: 'Pure Black Dark Theme'),
            trailing: Switch(
                value: LunaDatabaseValue.THEME_AMOLED.data,
                onChanged: (value) => LunaDatabaseValue.THEME_AMOLED.put(value),
            ),
        ),
    );

    Widget get _amoledThemeBordersTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [
            LunaDatabaseValue.THEME_AMOLED_BORDER.key,
            LunaDatabaseValue.THEME_AMOLED.key,
        ]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'AMOLED Borders'),
            subtitle: LSSubtitle(text: 'Add Subtle Borders Across the UI'),
            trailing: Switch(
                value: LunaDatabaseValue.THEME_AMOLED_BORDER.data,
                onChanged: LunaDatabaseValue.THEME_AMOLED.data
                    ? (value) => LunaDatabaseValue.THEME_AMOLED_BORDER.put(value)
                    : null,
            ),
        ),
    );

    Widget get _imageBackgroundOpacityTile {
        Future<void> _execute() async {
            List _values = await SettingsDialogs.changeBackgroundImageOpacity(context);
            if(_values[0]) LunaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.put(_values[1]);
        }
        return ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [LunaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.key]),
            builder: (context, box, widget) => LSCardTile(
                title: LSTitle(text: 'Background Image Opacity'),
                subtitle: LSSubtitle(text: LunaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.data == 0
                    ? 'Disabled'
                    : '${LunaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.data}%'
                ),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: _execute,
            ),
        );
    }

    Widget get _use24HourTime => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaDatabaseValue.USE_24_HOUR_TIME.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Use 24 Hour Time'),
            subtitle: LSSubtitle(text: 'Show Timestamps in 24 Hour Style'),
            trailing: Switch(
                value: LunaDatabaseValue.USE_24_HOUR_TIME.data,
                onChanged: (value) => LunaDatabaseValue.USE_24_HOUR_TIME.put(value),
            ),
        ),
    );
}
