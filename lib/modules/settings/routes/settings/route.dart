import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/firebase/core.dart';
import 'package:lunasea/firebase/messaging.dart';
import 'package:lunasea/router/routes/settings.dart';
import 'package:lunasea/system/in_app_purchase/in_app_purchase.dart';

class SettingsRoute extends StatefulWidget {
  const SettingsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsRoute> createState() => _State();
}

class _State extends State<SettingsRoute> with LunaScrollControllerMixin {
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

  PreferredSizeWidget _appBar() {
    return LunaAppBar(
      useDrawer: true,
      scrollControllers: [scrollController],
      title: LunaModule.SETTINGS.title,
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        if (LunaFirebase.isSupported)
          LunaBlock(
            title: 'settings.Account'.tr(),
            body: [TextSpan(text: 'settings.AccountDescription'.tr())],
            trailing: const LunaIconButton(icon: Icons.person_rounded),
            onTap: SettingsRoutes.ACCOUNT.go,
          ),
        LunaBlock(
          title: 'settings.Configuration'.tr(),
          body: [TextSpan(text: 'settings.ConfigurationDescription'.tr())],
          trailing: const LunaIconButton(icon: Icons.device_hub_rounded),
          onTap: SettingsRoutes.CONFIGURATION.go,
        ),
        if (LunaFirebaseMessaging.isSupported)
          LunaBlock(
            title: 'settings.Notifications'.tr(),
            body: [TextSpan(text: 'settings.NotificationsDescription'.tr())],
            trailing: const LunaIconButton(icon: Icons.notifications_rounded),
            onTap: SettingsRoutes.NOTIFICATIONS.go,
          ),
        LunaBlock(
          title: 'settings.Profiles'.tr(),
          body: [TextSpan(text: 'settings.ProfilesDescription'.tr())],
          trailing: const LunaIconButton(icon: Icons.switch_account_rounded),
          onTap: SettingsRoutes.PROFILES.go,
        ),
        LunaDivider(),
        if (LunaInAppPurchase.isSupported)
          LunaBlock(
            title: 'settings.Donations'.tr(),
            body: [TextSpan(text: 'settings.DonationsDescription'.tr())],
            trailing: const LunaIconButton(icon: Icons.attach_money_rounded),
            onTap: SettingsRoutes.DONATIONS.go,
          ),
        LunaBlock(
          title: 'settings.Resources'.tr(),
          body: [TextSpan(text: 'settings.ResourcesDescription'.tr())],
          trailing: const LunaIconButton(icon: Icons.help_outline_rounded),
          onTap: SettingsRoutes.RESOURCES.go,
        ),
        LunaBlock(
          title: 'settings.System'.tr(),
          body: [TextSpan(text: 'settings.SystemDescription'.tr())],
          trailing: const LunaIconButton(icon: Icons.settings_rounded),
          onTap: SettingsRoutes.SYSTEM.go,
        ),
      ],
    );
  }
}
