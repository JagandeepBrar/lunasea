import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationAppearanceRouter extends SettingsPageRouter {
  SettingsConfigurationAppearanceRouter()
      : super('/settings/configuration/appearance');

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
      title: 'settings.Appearance'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        _amoledTheme(),
        _amoledThemeBorders(),
        _imageBackgroundOpacity(),
      ],
    );
  }

  Widget _amoledTheme() {
    LunaDatabaseValue _db = LunaDatabaseValue.THEME_AMOLED;
    return _db.listen(
      builder: (context, _, __) => LunaBlock(
        title: 'settings.AmoledTheme'.tr(),
        body: [
          TextSpan(text: 'settings.AmoledThemeDescription'.tr()),
        ],
        trailing: LunaSwitch(
          value: _db.data,
          onChanged: (value) {
            _db.put(value);
            LunaTheme().initialize();
          },
        ),
      ),
    );
  }

  Widget _amoledThemeBorders() {
    return ValueListenableBuilder(
      valueListenable: Database.lunaSeaBox.listenable(
        keys: [
          LunaDatabaseValue.THEME_AMOLED_BORDER.key,
          LunaDatabaseValue.THEME_AMOLED.key,
        ],
      ),
      builder: (context, _, __) => LunaBlock(
        title: 'settings.AmoledThemeBorders'.tr(),
        body: [
          TextSpan(text: 'settings.AmoledThemeBordersDescription'.tr()),
        ],
        trailing: LunaSwitch(
          value: LunaDatabaseValue.THEME_AMOLED_BORDER.data,
          onChanged: LunaDatabaseValue.THEME_AMOLED.data
              ? (value) => LunaDatabaseValue.THEME_AMOLED_BORDER.put(value)
              : null,
        ),
      ),
    );
  }

  Widget _imageBackgroundOpacity() {
    LunaDatabaseValue _db = LunaDatabaseValue.THEME_IMAGE_BACKGROUND_OPACITY;
    return _db.listen(
      builder: (context, _, __) => LunaBlock(
        title: 'settings.BackgroundImageOpacity'.tr(),
        body: [
          TextSpan(
            text: _db.data == 0 ? 'lunasea.Disabled'.tr() : '${_db.data}%',
          ),
        ],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          Tuple2<bool, int> result =
              await SettingsDialogs().changeBackgroundImageOpacity(context);
          if (result.item1) _db.put(result.item2);
        },
      ),
    );
  }
}
