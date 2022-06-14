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
      appBar: _appBar() as PreferredSizeWidget?,
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
    const _db = LunaSeaDatabase.THEME_AMOLED;
    return _db.watch(
      builder: (context, _) => LunaBlock(
        title: 'settings.AmoledTheme'.tr(),
        body: [
          TextSpan(text: 'settings.AmoledThemeDescription'.tr()),
        ],
        trailing: LunaSwitch(
          value: _db.read(),
          onChanged: (value) {
            _db.update(value);
            LunaTheme().initialize();
          },
        ),
      ),
    );
  }

  Widget _amoledThemeBorders() {
    return LunaBox.lunasea.watch(
      selectItems: [
        LunaSeaDatabase.THEME_AMOLED_BORDER,
        LunaSeaDatabase.THEME_AMOLED,
      ],
      builder: (context, _) => LunaBlock(
        title: 'settings.AmoledThemeBorders'.tr(),
        body: [
          TextSpan(text: 'settings.AmoledThemeBordersDescription'.tr()),
        ],
        trailing: LunaSwitch(
          value: LunaSeaDatabase.THEME_AMOLED_BORDER.read(),
          onChanged: LunaSeaDatabase.THEME_AMOLED.read()
              ? LunaSeaDatabase.THEME_AMOLED_BORDER.update
              : null,
        ),
      ),
    );
  }

  Widget _imageBackgroundOpacity() {
    const _db = LunaSeaDatabase.THEME_IMAGE_BACKGROUND_OPACITY;
    return _db.watch(
      builder: (context, _) => LunaBlock(
        title: 'settings.BackgroundImageOpacity'.tr(),
        body: [
          TextSpan(
            text: _db.read() == 0 ? 'lunasea.Disabled'.tr() : '${_db.read()}%',
          ),
        ],
        trailing: const LunaIconButton.arrow(),
        onTap: () async {
          Tuple2<bool, int> result =
              await SettingsDialogs().changeBackgroundImageOpacity(context);
          if (result.item1) _db.update(result.item2);
        },
      ),
    );
  }
}
