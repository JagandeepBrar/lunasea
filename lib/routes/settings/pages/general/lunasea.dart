import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class SettingsGeneralLunaSea extends StatefulWidget {
    @override
    State<SettingsGeneralLunaSea> createState() => _State();
}

class _State extends State<SettingsGeneralLunaSea> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    String _version = 'Unknown';
    String _buildNumber = 'Unknown';

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            body: _body,
        );
    }

    @override
    void initState() {
        super.initState();
        _fetchVersion();
    }

    void _fetchVersion() async {
        PackageInfo info = await PackageInfo.fromPlatform();
        if(mounted) setState(() {
            _version = info.version;
            _buildNumber = info.buildNumber;
        });
    }

    Widget get _body => LSListView(
        children: <Widget>[
            LSCard(
                title: LSTitle(text: 'Version: $_version ($_buildNumber)'),
                subtitle: LSSubtitle(text: 'View recent changes in LunaSea'),
                trailing: LSIconButton(icon: Icons.system_update),
                onTap: () async {
                    List changes = await System.getChangelog();
                    await SystemDialogs.showChangelogPrompt(context, changes);
                },
            ),
            LSDivider(),
            LSCard(
                title: LSTitle(text: 'Documentation'),
                subtitle: LSSubtitle(text: 'Discover all the features of LunaSea'),
                trailing: LSIconButton(icon: CustomIcons.documentation),
                onTap: () async => await Constants.URL_DOCUMENTATION.lsLinks_OpenLink(),
            ),
            LSCard(
                title: LSTitle(text: 'GitHub'),
                subtitle: LSSubtitle(text: 'View the source code'),
                trailing: LSIconButton(icon: CustomIcons.github),
                onTap: () async => await Constants.URL_GITHUB.lsLinks_OpenLink(),
            ),
            LSCard(
                title: LSTitle(text: 'Reddit'),
                subtitle: LSSubtitle(text: 'Get support and request features'),
                trailing: LSIconButton(icon: CustomIcons.reddit),
                onTap: () async => await Constants.URL_REDDIT.lsLinks_OpenLink(),
            ),
            LSCard(
                title: LSTitle(text: 'Website'),
                subtitle: LSSubtitle(text: 'Visit LunaSea\'s website'),
                trailing: LSIconButton(icon: CustomIcons.home),
                onTap: () async => await Constants.URL_WEBSITE.lsLinks_OpenLink(),
            ),
        ],
    );
}
