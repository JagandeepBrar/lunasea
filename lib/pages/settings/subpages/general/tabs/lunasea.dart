import 'package:flutter/material.dart';
import 'package:lunasea/logic/system/version.dart';
import 'package:lunasea/system/functions.dart';
import 'package:lunasea/system/ui.dart';
import 'package:package_info/package_info.dart';

class LunaSea extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return _LunaSeaWidget();
    }
}

class _LunaSeaWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _LunaSeaState();
    }
}

class _LunaSeaState extends State<StatefulWidget> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    String _version;
    String _buildNumber;

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            body: _systemLinks(),
        );
    }

    @override
    void initState() {
        super.initState();
        _fetchVersion();
    }

    void _fetchVersion() async {
        PackageInfo info = await PackageInfo.fromPlatform();
        if(mounted) {
            setState(() {
                _version = info.version;
                _buildNumber = info.buildNumber;
            });
        }
    }

    Widget _systemLinks() {
        return Scrollbar(
            child: ListView(
                children: <Widget>[
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Homepage'),
                            subtitle: Elements.getSubtitle('Visit LunaSea\'s website'),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.home),
                                onPressed: null,
                            ),
                            onTap: () async {
                                await Functions.openURL('https://www.lunasea.app');
                            },
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('GitHub'),
                            subtitle: Elements.getSubtitle('Report bugs & request features'),
                            trailing: IconButton(
                                icon: Elements.getIcon(CustomIcons.github_circled),
                                onPressed: null,
                            ),
                            onTap: () async {
                                await Functions.openURL('https://github.com/JagandeepBrar/LunaSea');
                            },
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Reddit'),
                            subtitle: Elements.getSubtitle('Ask questions & get support'),
                            trailing: IconButton(
                                icon: Elements.getIcon(CustomIcons.reddit_alien),
                                onPressed: null,
                            ),
                            onTap: () async {
                                await Functions.openURL('https://www.reddit.com/r/LunaSeaApp');
                            },
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                    Elements.getDivider(),
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Changelog'),
                            subtitle: Elements.getSubtitle('View recent changes in LunaSea'),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.track_changes),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List changes = await System.getChangelog();
                                await SystemDialogs.showChangelogPrompt(context, changes);
                            },
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Version: $_version+$_buildNumber'),
                            subtitle: Elements.getSubtitle('Check for updates'),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.system_update),
                                onPressed: null,
                            ),
                            onTap: () async {
                                if(await System.checkVersion()) {
                                    Notifications.showSnackBar(_scaffoldKey, 'A new version of LunaSea is available!');
                                } else {
                                    Notifications.showSnackBar(_scaffoldKey, 'LunaSea is up to date');
                                }
                            },
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                ],
                padding: Elements.getListViewPadding(),
            ),
        );
    }
}
