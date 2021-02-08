import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:package_info/package_info.dart';

class SettingsSystemRouter extends LunaPageRouter {
    SettingsSystemRouter() : super('/settings/system');

    @override
    void defineRoute(FluroRouter router) => super.noParameterRouteDefinition(router, _SettingsSystemRoute());
}

class _SettingsSystemRoute extends StatefulWidget {
    @override
    State<_SettingsSystemRoute> createState() => _State();
}

class _State extends State<_SettingsSystemRoute> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    
    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar,
            body: _body,
        );
    }

    Widget get _appBar => LunaAppBar(title: 'System');

    Widget get _body => LSListView(
        children: <Widget>[
            _versionTile,
            _logsTile,
            LSDivider(),
            SettingsSystemBackupRestoreBackupTile(),
            SettingsSystemBackupRestoreRestoreTile(),
            LSDivider(),
            _enableSentryTile,
            _clearConfigurationTile,
        ],
    );

    Widget get _logsTile => LSCardTile(
        title: LSTitle(text: 'Logs'),
        subtitle: LSSubtitle(text: 'View, Export, & Clear Logs'),
        trailing: LSIconButton(icon: Icons.developer_mode),
        onTap: () async => SettingsSystemLogsRouter().navigateTo(context),
    );

    Widget get _versionTile => FutureBuilder(
        future: PackageInfo.fromPlatform(),
        builder: (context, AsyncSnapshot<PackageInfo> snapshot) => LSCardTile(
            title: LSTitle(
                text: snapshot.hasData
                    ? 'Version: ${snapshot.data.version} (${snapshot.data.buildNumber})'
                    : 'Version: Loading...',
            ),
            subtitle: LSSubtitle(text: 'View Recent Changes'),
            trailing: LSIconButton(icon: Icons.system_update),
            onTap: () async {
                PackageInfo.fromPlatform()
                .then((package) => LunaBottomModalSheet().showChangelog(context, package.buildNumber))
                .catchError((error, stack) {
                    LunaLogger().error('Failed to fetch PackageInfo', error, stack);
                    showLunaErrorSnackBar(context: context, title: 'Failed to Load Changelog', error: error);
                });
            }
        ),
    );
    
    Widget get _enableSentryTile => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [LunaDatabaseValue.ENABLED_SENTRY.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: 'Sentry'),
            subtitle: LSSubtitle(text: 'Crash and Error Tracking'),
            trailing: LunaSwitch(
                value: LunaDatabaseValue.ENABLED_SENTRY.data,
                onChanged: (value) async {
                    List _values = value
                        ? [true]
                        : await SettingsDialogs.disableSentryWarning(context);
                    if(_values[0]) LunaDatabaseValue.ENABLED_SENTRY.put(value);
                }
            ),
        ),
    );

    Widget get _clearConfigurationTile {
        Future<void> _execute() async {
            List values = await SettingsDialogs.clearConfiguration(context);
            if(values[0]) {
                Database.setDefaults(clearAlerts: true);
                LunaFirebaseAuth().signOut();
                LunaState.reset(context);
                showLunaSuccessSnackBar(
                    context: context,
                    title: 'Configuration Cleared',
                    message: 'Your configuration has been cleared',
                );
            }
        }
        return LSCardTile(
            title: LSTitle(text: 'Clear Configuration'),
            subtitle: LSSubtitle(text: 'Clean Slate'),
            trailing: LSIconButton(icon: Icons.delete_sweep),
            onTap: _execute,
        );
    }
}
