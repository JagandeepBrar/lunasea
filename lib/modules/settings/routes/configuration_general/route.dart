import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/tables/bios.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/system/localization.dart';
import 'package:lunasea/system/network/network.dart';

class ConfigurationGeneralRoute extends StatefulWidget {
  const ConfigurationGeneralRoute({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _State();
}

class _State extends State<ConfigurationGeneralRoute>
    with LunaScrollControllerMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return LunaAppBar(
      title: 'settings.General'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        ..._appearance(),
        ..._localization(),
        if (LunaNetwork.isSupported) ..._network(),
      ],
    );
  }

  List<Widget> _appearance() {
    return [
      LunaHeader(text: 'settings.Appearance'.tr()),
      _imageBackgroundOpacity(),
      _amoledTheme(),
      _amoledThemeBorders(),
    ];
  }

  List<Widget> _localization() {
    return [
      LunaHeader(text: 'settings.Localization'.tr()),
      _language(),
      _use24HourTime(),
    ];
  }

  List<Widget> _modules() {
    return [
      LunaHeader(text: 'dashboard.Modules'.tr()),
      _bootModule(),
    ];
  }

  List<Widget> _network() {
    return [
      LunaHeader(text: 'settings.Network'.tr()),
      _useTLSValidation(),
    ];
  }

  Widget _amoledTheme() {
    const _db = LunaSeaDatabase.THEME_AMOLED;
    return _db.listenableBuilder(
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
    return LunaBox.lunasea.listenableBuilder(
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
    return _db.listenableBuilder(
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

  Widget _useTLSValidation() {
    const _db = LunaSeaDatabase.NETWORKING_TLS_VALIDATION;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'settings.TLSCertificateValidation'.tr(),
        body: [
          TextSpan(text: 'settings.TLSCertificateValidationDescription'.tr()),
        ],
        trailing: LunaSwitch(
          value: _db.read(),
          onChanged: (data) {
            _db.update(data);
            if (LunaNetwork.isSupported) LunaNetwork().initialize();
          },
        ),
      ),
    );
  }

  Widget _language() {
    String? _language = LunaLanguage.fromLocale(context.locale)?.name;
    return LunaBlock(
      title: 'settings.Language'.tr(),
      body: [TextSpan(text: _language ?? LunaUI.TEXT_EMDASH)],
      trailing: const LunaIconButton(icon: Icons.language_rounded),
      onTap: () async {
        final result = await SettingsDialogs().changeLanguage(context);
        if (result.item1) result.item2!.use();
      },
    );
  }

  Widget _use24HourTime() {
    const _db = LunaSeaDatabase.USE_24_HOUR_TIME;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'settings.Use24HourTime'.tr(),
        body: [TextSpan(text: 'settings.Use24HourTimeDescription'.tr())],
        trailing: LunaSwitch(
          value: _db.read(),
          onChanged: _db.update,
        ),
      ),
    );
  }

  Widget _bootModule() {
    const _db = BIOSDatabase.BOOT_MODULE;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'settings.BootModule'.tr(),
        body: [TextSpan(text: _db.read().title)],
        trailing: LunaIconButton(icon: _db.read().icon),
        onTap: () async {
          final result = await SettingsDialogs().selectBootModule();
          if (result.item1) {
            BIOSDatabase.BOOT_MODULE.update(result.item2!);
          }
        },
      ),
    );
  }
}
