import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules.dart';

class SettingsConfigurationRouter extends SettingsPageRouter {
  SettingsConfigurationRouter() : super('/settings/configuration');

  @override
  Widget widget() => _Widget();

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
      title: 'settings.Configuration'.tr(),
      scrollControllers: [scrollController],
      actions: [
        LunaIconButton(
          icon: Icons.switch_account_rounded,
          onPressed: () async {
            Tuple2<bool, String> results =
                await SettingsDialogs().enabledProfile(
              LunaState.navigatorKey.currentContext,
              LunaProfile().profilesList(),
            );
            if (results.item1 &&
                results.item2 != LunaDatabaseValue.ENABLED_PROFILE.data)
              LunaProfile().safelyChangeProfiles(results.item2);
          },
        ),
      ],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        LunaListTile(
          context: context,
          title: LunaText.title(text: 'settings.Appearance'.tr()),
          subtitle:
              LunaText.subtitle(text: 'settings.AppearanceDescription'.tr()),
          trailing: LunaIconButton(icon: Icons.brush_rounded),
          onTap: () async =>
              SettingsConfigurationAppearanceRouter().navigateTo(context),
        ),
        LunaListTile(
          context: context,
          title: LunaText.title(text: 'settings.Drawer'.tr()),
          subtitle: LunaText.subtitle(text: 'settings.DrawerDescription'.tr()),
          trailing: LunaIconButton(icon: Icons.menu_rounded),
          onTap: () async =>
              SettingsConfigurationDrawerRouter().navigateTo(context),
        ),
        LunaListTile(
          context: context,
          title: LunaText.title(text: 'settings.Localization'.tr()),
          subtitle:
              LunaText.subtitle(text: 'settings.LocalizationDescription'.tr()),
          trailing: LunaIconButton(icon: Icons.translate_rounded),
          onTap: () async =>
              SettingsConfigurationLocalizationRouter().navigateTo(context),
        ),
        if (Platform.isIOS)
          LunaDatabaseValue.SELECTED_BROWSER.listen(
            builder: (context, box, widget) => LunaListTile(
              context: context,
              title: LunaText.title(text: 'settings.OpenLinksIn'.tr()),
              subtitle: LunaText.subtitle(
                  text: (LunaDatabaseValue.SELECTED_BROWSER.data as LunaBrowser)
                      .name),
              trailing: LunaIconButton(
                  icon: (LunaDatabaseValue.SELECTED_BROWSER.data as LunaBrowser)
                      .icon),
              onTap: () async {
                Tuple2<bool, LunaBrowser> result =
                    await SettingsDialogs().changeBrowser(context);
                if (result.item1)
                  LunaDatabaseValue.SELECTED_BROWSER.put(result.item2);
              },
            ),
          ),
        if (LunaQuickActions.isPlatformCompatible)
          LunaListTile(
            context: context,
            title: LunaText.title(text: 'settings.QuickActions'.tr()),
            subtitle: LunaText.subtitle(
              text: 'settings.QuickActionsDescription'.tr(),
            ),
            trailing: LunaIconButton(icon: Icons.rounded_corner_rounded),
            onTap: () async =>
                SettingsConfigurationQuickActionsRouter().navigateTo(context),
          ),
        const LunaDivider(),
        ..._moduleList(),
      ],
    );
  }

  List<Widget> _moduleList() {
    return ([LunaModule.DASHBOARD, ...LunaModule.DASHBOARD.allModules()])
        .map(_tileFromModuleMap)
        .toList();
  }

  Widget _tileFromModuleMap(LunaModule module) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: module.name),
      subtitle: LunaText.subtitle(
        text: 'settings.ConfigureModule'.tr(args: [module.name]),
      ),
      trailing: LunaIconButton(icon: module.icon),
      onTap: () async => module.settingsPage.navigateTo(context),
    );
  }
}
