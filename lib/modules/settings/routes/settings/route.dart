import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsHomeRouter extends SettingsPageRouter {
  SettingsHomeRouter() : super('/settings');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router, homeRoute: true);
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
      drawer: _drawer(),
      body: _body(),
    );
  }

  Widget _drawer() => LunaDrawer(page: LunaModule.SETTINGS.key);

  Widget _appBar() {
    return LunaAppBar(
      useDrawer: true,
      scrollControllers: [scrollController],
      title: LunaModule.SETTINGS.name,
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        LunaBlock(
          title: 'settings.Account'.tr(),
          body: [TextSpan(text: 'settings.AccountDescription'.tr())],
          trailing: const LunaIconButton(icon: Icons.person_rounded),
          onTap: () async => SettingsAccountRouter().navigateTo(context),
        ),
        LunaBlock(
          title: 'settings.Configuration'.tr(),
          body: [TextSpan(text: 'settings.ConfigurationDescription'.tr())],
          trailing: const LunaIconButton(icon: Icons.device_hub_rounded),
          onTap: () async => SettingsConfigurationRouter().navigateTo(context),
        ),
        LunaBlock(
          title: 'settings.Notifications'.tr(),
          body: [TextSpan(text: 'settings.NotificationsDescription'.tr())],
          trailing: const LunaIconButton(icon: Icons.notifications_rounded),
          onTap: () async => SettingsNotificationsRouter().navigateTo(context),
        ),
        LunaBlock(
          title: 'settings.Profiles'.tr(),
          body: [TextSpan(text: 'settings.ProfilesDescription'.tr())],
          trailing: const LunaIconButton(icon: Icons.switch_account_rounded),
          onTap: () async => SettingsProfilesRouter().navigateTo(context),
        ),
        const LunaDivider(),
        if (LunaInAppPurchases.isPlatformCompatible)
          LunaBlock(
            title: 'settings.Donations'.tr(),
            body: [TextSpan(text: 'settings.DonationsDescription'.tr())],
            trailing: const LunaIconButton(icon: Icons.attach_money_rounded),
            onTap: () async => SettingsDonationsRouter().navigateTo(context),
          ),
        LunaBlock(
          title: 'settings.Resources'.tr(),
          body: [TextSpan(text: 'settings.ResourcesDescription'.tr())],
          trailing: const LunaIconButton(icon: Icons.help_outline_rounded),
          onTap: () async => SettingsResourcesRouter().navigateTo(context),
        ),
        LunaBlock(
          title: 'settings.System'.tr(),
          body: [TextSpan(text: 'settings.SystemDescription'.tr())],
          trailing: const LunaIconButton(icon: Icons.settings_rounded),
          onTap: () async => SettingsSystemRouter().navigateTo(context),
        ),
        if (kDebugMode)
          LunaBlock(
            title: 'settings.DebugMenu'.tr(),
            body: [TextSpan(text: 'settings.DebugMenuDescription'.tr())],
            trailing: const LunaIconButton(icon: Icons.bug_report_rounded),
            onTap: () async => SettingsDebugMenuRouter().navigateTo(context),
          ),
      ],
    );
  }
}
