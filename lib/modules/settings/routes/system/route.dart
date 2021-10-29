import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsSystemRouter extends SettingsPageRouter {
  SettingsSystemRouter() : super('/settings/system');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router);
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
      title: 'System',
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: <Widget>[
        _versionInformation(),
        _logs(),
        const LunaDivider(),
        SettingsSystemBackupRestoreBackupTile(),
        SettingsSystemBackupRestoreRestoreTile(),
        const LunaDivider(),
        if (LunaFirebaseAnalytics.isPlatformCompatible) _enableAnalytics(),
        if (LunaFirebaseCrashlytics.isPlatformCompatible) _enableCrashlytics(),
        if (LunaFirebaseCrashlytics.isPlatformCompatible ||
            LunaFirebaseAnalytics.isPlatformCompatible)
          const LunaDivider(),
        if (kDebugMode) _hideTooltipBanners(),
        _clearConfiguration(),
      ],
    );
  }

  Widget _versionInformation() {
    return FutureBuilder(
        future: PackageInfo.fromPlatform(),
        builder: (context, AsyncSnapshot<PackageInfo> snapshot) {
          String version = 'Loading${LunaUI.TEXT_ELLIPSIS}';
          if (snapshot.hasError) version = 'Unknown';
          if (snapshot.hasData)
            version = '${snapshot.data.version} (${snapshot.data.buildNumber})';
          return LunaListTile(
            context: context,
            title: LunaText.title(text: 'Version: $version'),
            subtitle: LunaText.subtitle(text: 'View Recent Changes'),
            trailing: LunaIconButton(icon: Icons.system_update),
            onTap: () async => LunaChangelog().showChangelog(
                snapshot.data?.version, snapshot.data?.buildNumber),
          );
        });
  }

  Widget _logs() {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Logs'),
      subtitle: LunaText.subtitle(text: 'View, Export, and Clear Logs'),
      trailing: LunaIconButton(icon: Icons.developer_mode),
      onTap: () async => SettingsSystemLogsRouter().navigateTo(context),
    );
  }

  Widget _enableAnalytics() {
    return LunaDatabaseValue.ENABLE_FIREBASE_ANALYTICS.listen(
      builder: (context, box, _) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Firebase Analytics'),
        subtitle: LunaText.subtitle(text: 'User Engagement Tracking'),
        trailing: LunaSwitch(
          value: LunaDatabaseValue.ENABLE_FIREBASE_ANALYTICS.data,
          onChanged: (value) async {
            LunaDatabaseValue.ENABLE_FIREBASE_ANALYTICS.put(value);
            LunaFirebaseAnalytics().setEnabledState();
          },
        ),
      ),
    );
  }

  Widget _enableCrashlytics() {
    return LunaDatabaseValue.ENABLE_FIREBASE_CRASHLYTICS.listen(
      builder: (context, box, _) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Firebase Crashlytics'),
        subtitle: LunaText.subtitle(text: 'Crash and Error Tracking'),
        trailing: LunaSwitch(
            value: LunaDatabaseValue.ENABLE_FIREBASE_CRASHLYTICS.data,
            onChanged: (value) async {
              LunaDatabaseValue enabled =
                  LunaDatabaseValue.ENABLE_FIREBASE_CRASHLYTICS;
              if (enabled.data) {
                bool result =
                    await SettingsDialogs().disableCrashlyticsWarning(context);
                if (result) enabled.put(value);
              } else {
                enabled.put(value);
              }
              LunaFirebaseCrashlytics().setEnabledState();
            }),
      ),
    );
  }

  Widget _hideTooltipBanners() {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Dismiss Tooltip Banners'),
      subtitle: LunaText.subtitle(text: 'Hide Tooltips, Alerts, & Hints'),
      trailing: LunaIconButton(icon: Icons.rule_rounded),
      onTap: () async {
        bool result = await SettingsDialogs().dismissTooltipBanners(context);
        if (result) {
          for (LunaModule module in LunaModule.values) {
            module.hideAllBanners();
          }
          showLunaSuccessSnackBar(
            title: 'Dismissed Banners',
            message: 'All banners have been dismissed',
          );
        }
      },
    );
  }

  Widget _clearConfiguration() {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Clear Configuration'),
      subtitle: LunaText.subtitle(text: 'Clean Slate'),
      trailing: LunaIconButton(icon: Icons.delete_sweep),
      onTap: () async {
        bool result = await SettingsDialogs().clearConfiguration(context);
        if (result) {
          Database().setDefaults(clearEverything: true);
          LunaFirebaseAuth().signOut();
          LunaState.reset(context);
          showLunaSuccessSnackBar(
            title: 'Configuration Cleared',
            message: 'Your configuration has been cleared',
          );
        }
      },
    );
  }
}
