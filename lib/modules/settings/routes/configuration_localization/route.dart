import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/system/localization.dart';

class ConfigurationLocalizationRoute extends StatefulWidget {
  const ConfigurationLocalizationRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationLocalizationRoute> createState() => _State();
}

class _State extends State<ConfigurationLocalizationRoute>
    with LunaScrollControllerMixin {
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
}
