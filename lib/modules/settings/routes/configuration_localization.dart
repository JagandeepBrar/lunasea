import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationLocalizationRouter extends SettingsPageRouter {
    SettingsConfigurationLocalizationRouter() : super('/settings/configuration/localization');
    
    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsConfigurationLocalizationRoute());
}

class _SettingsConfigurationLocalizationRoute extends StatefulWidget {
    @override
    State<_SettingsConfigurationLocalizationRoute> createState() => _State();
}

class _State extends State<_SettingsConfigurationLocalizationRoute> with LunaScrollControllerMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    Widget build(BuildContext context) {
        return  LunaScaffold(
            scaffoldKey: _scaffoldKey,
            appBar: _appBar(),
            body: _body(),
        );
    }

    Widget _appBar() {
        return LunaAppBar(
            title: 'Localization',
            scrollControllers: [scrollController],
        );
    }

    Widget _body() {
        return LunaListView(
            controller: scrollController,
            children: [
                _language(),
                _use24HourTime(),
            ],
        );
    }

    Widget _language() {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Language'),
            subtitle: LunaText.subtitle(text: LunaLanguage.ENGLISH.fromLocale(context.locale)?.name ?? LunaUI.TEXT_EMDASH),
            trailing: LunaIconButton(icon: Icons.language),
            onTap: () async {
                Tuple2<bool, LunaLanguage> result = await SettingsDialogs().changeLanguage(context);
                if(result.item1) result.item2.use(context);
            },
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
