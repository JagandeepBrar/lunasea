import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationAppearanceRouter extends LunaPageRouter {
    static const ROUTE_NAME = '/settings/configuration/appearance';

    Future<void> navigateTo(BuildContext context) async => LunaRouter.router.navigateTo(
        context,
        ROUTE_NAME,
    );

    String route(List parameters) => ROUTE_NAME;
    
    void defineRoutes(FluroRouter router) => router.define(
        ROUTE_NAME,
        handler: Handler(handlerFunc: (context, params) => _Widget()),
        transitionType: LunaRouter.transitionType,
    );
}

class _Widget extends StatefulWidget {
    @override
    State<_Widget> createState() => _State();
}

class _State extends State<_Widget> {
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
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.THEME_AMOLED.key]),
        builder: (context, box, widget) => LSCardTile(
            title: LSTitle(text: 'AMOLED Dark Theme'),
            subtitle: LSSubtitle(text: 'Pure Black Dark Theme'),
            trailing: Switch(
                value: LunaSeaDatabaseValue.THEME_AMOLED.data,
                onChanged: (value) => LunaSeaDatabaseValue.THEME_AMOLED.put(value),
            ),
        ),
    );

    Widget get _amoledThemeBordersTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [
            LunaSeaDatabaseValue.THEME_AMOLED_BORDER.key,
            LunaSeaDatabaseValue.THEME_AMOLED.key,
        ]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'AMOLED Borders'),
            subtitle: LSSubtitle(text: 'Add Subtle Borders Across the UI'),
            trailing: Switch(
                value: LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data,
                onChanged: LunaSeaDatabaseValue.THEME_AMOLED.data
                    ? (value) => LunaSeaDatabaseValue.THEME_AMOLED_BORDER.put(value)
                    : null,
            ),
        ),
    );

    Widget get _imageBackgroundOpacityTile {
        Future<void> _execute() async {
            List _values = await SettingsDialogs.changeBackgroundImageOpacity(context);
            if(_values[0]) LunaSeaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.put(_values[1]);
        }
        return ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.key]),
            builder: (context, box, widget) => LSCardTile(
                title: LSTitle(text: 'Background Image Opacity'),
                subtitle: LSSubtitle(text: LunaSeaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.data == 0
                    ? 'Disabled'
                    : '${LunaSeaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY.data}%'
                ),
                trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                onTap: _execute,
            ),
        );
    }

    Widget get _use24HourTime => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.USE_24_HOUR_TIME.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Use 24 Hour Time'),
            subtitle: LSSubtitle(text: 'Show Timestamps in 24 Hour Style'),
            trailing: Switch(
                value: LunaSeaDatabaseValue.USE_24_HOUR_TIME.data,
                onChanged: (value) => LunaSeaDatabaseValue.USE_24_HOUR_TIME.put(value),
            ),
        ),
    );
}
