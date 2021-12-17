import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationLocalizationRouter extends SettingsPageRouter {
  SettingsConfigurationLocalizationRouter()
      : super('/settings/configuration/localization');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'settings.Localization'.tr(),
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
    String _language = LunaLanguage.ENGLISH.fromLocale(context.locale)?.name;
    return LunaBlock(
      title: 'settings.Language'.tr(),
      body: [TextSpan(text: _language ?? LunaUI.TEXT_EMDASH)],
      trailing: const LunaIconButton(icon: Icons.language_rounded),
      onTap: () async {
        Tuple2<bool, LunaLanguage> result =
            await SettingsDialogs().changeLanguage(context);
        if (result.item1) {
          result.item2.use(context);
          Intl.defaultLocale = result.item2?.languageTag;
        }
      },
    );
  }

  Widget _use24HourTime() {
    LunaDatabaseValue _db = LunaDatabaseValue.USE_24_HOUR_TIME;
    return _db.listen(
      builder: (context, _, __) => LunaBlock(
        title: 'Use 24 Hour Time',
        body: const [TextSpan(text: 'Show Timestamps in 24 Hour Style')],
        trailing: LunaSwitch(
          value: _db.data,
          onChanged: (value) => _db.put(value),
        ),
      ),
    );
  }
}
