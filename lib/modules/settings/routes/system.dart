import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsSystem extends StatefulWidget {
    static const ROUTE_NAME = '/settings/system';
    
    @override
    State<SettingsSystem> createState() => _State();
}

class _State extends State<SettingsSystem> with AutomaticKeepAliveClientMixin {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    String _version = '1.0.0';
    String _buildNumber = '1';

    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
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
            ..._resources,
            ..._system,
        ],
    );

    List<Widget> get _system => [
        LSHeader(
            text: 'System',
            subtitle: 'System information and utilities for LunaSea',
        ),
        LSCardTile(
            title: LSTitle(text: 'Version: $_version ($_buildNumber)'),
            subtitle: LSSubtitle(text: 'View Recent Changes'),
            trailing: LSIconButton(icon: Icons.system_update),
            onTap: () async => await Constants.URL_CHANGELOG.lsLinks_OpenLink(),
        ),
        LSCardTile(
            title: LSTitle(text: 'Licenses'),
            subtitle: LSSubtitle(text: 'License Attributions'),
            trailing: LSIconButton(icon: Icons.description),
            onTap: () async => await Constants.URL_LICENSES.lsLinks_OpenLink(),
        ),
        SettingsSystemClearImageCacheTile(),
        SettingsSystemClearConfigurationTile(),
    ];

    List<Widget> get _resources => [
        LSHeader(
            text: 'Resources',
            subtitle: 'Useful resources to get the most out of LunaSea',
        ),
        LSCardTile(
            title: LSTitle(text: 'Documentation'),
            subtitle: LSSubtitle(text: 'View the Documentation'),
            trailing: LSIconButton(icon: CustomIcons.documentation),
            onTap: () async => await Constants.URL_DOCUMENTATION.lsLinks_OpenLink(),
        ),
        LSCardTile(
            title: LSTitle(text: 'Donations'),
            subtitle: LSSubtitle(text: 'Donate to the Developer'),
            trailing: LSIconButton(icon: Icons.attach_money),
            onTap: () async => await Navigator.of(context).pushNamed(SettingsSystemDonations.ROUTE_NAME),
        ),
        LSCardTile(
            title: LSTitle(text: 'Feedback Board'),
            subtitle: LSSubtitle(text: 'Request New Features'),
            trailing: LSIconButton(icon: Icons.speaker_notes),
            onTap: () async => await Constants.URL_FEEDBACK.lsLinks_OpenLink(),
        ),
        LSCardTile(
            title: LSTitle(text: 'GitHub'),
            subtitle: LSSubtitle(text: 'View the Source Code'),
            trailing: LSIconButton(icon: CustomIcons.github),
            onTap: () async => await Constants.URL_GITHUB.lsLinks_OpenLink(),
        ),
        LSCardTile(
            title: LSTitle(text: 'Reddit'),
            subtitle: LSSubtitle(text: 'Ask Questions & Get Support'),
            trailing: LSIconButton(icon: CustomIcons.reddit),
            onTap: () async => await Constants.URL_REDDIT.lsLinks_OpenLink(),
        ),
        LSCardTile(
            title: LSTitle(text: 'Website'),
            subtitle: LSSubtitle(text: 'Visit LunaSea\'s Website'),
            trailing: LSIconButton(icon: CustomIcons.home),
            onTap: () async => await Constants.URL_WEBSITE.lsLinks_OpenLink(),
        ),
    ];
}
