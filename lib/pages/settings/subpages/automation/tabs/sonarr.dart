import 'package:flutter/material.dart';
import 'package:lunasea/configuration/values.dart';
import 'package:lunasea/logic/automation/sonarr.dart';
import 'package:lunasea/system/ui.dart';

class Sonarr extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return _SonarrWidget();
    }
}

class _SonarrWidget extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        return _SonarrState();
    }
}

class _SonarrState extends State<StatefulWidget> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    List<dynamic> _sonarrValues;

    @override
    void initState() {
        super.initState();
        _refreshData();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            body: _sonarrSettings(),
            floatingActionButton: _buildFloatingActionButton(),
        );
    }

    void _refreshData() {
        if(mounted) {
            setState(() {
                _sonarrValues = List.from(Values.sonarrValues);
            });
        }
    }

    Widget _buildFloatingActionButton() {
        return FloatingActionButton(
            heroTag: null,
            tooltip: 'Save Settings',
            child: Elements.getIcon(Icons.save),
            onPressed: () async {
                await Values.setSonarr(_sonarrValues);
                Notifications.showSnackBar(_scaffoldKey, 'Settings saved');
            },
        );
    }

    Widget _sonarrSettings() {
        return Scrollbar(
            child: ListView(
                children: <Widget>[
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Enable Sonarr'),
                            trailing: Switch(
                                value: _sonarrValues[0],
                                onChanged: (value) {
                                    if(mounted) {
                                        setState(() {
                                            _sonarrValues[0] = value;
                                        });
                                    }
                                },
                            ),
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Host'),
                            subtitle: Elements.getSubtitle(_sonarrValues[1] == '' ? 'Not Set' : _sonarrValues[1], preventOverflow: true),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Sonarr Host', prefill: _sonarrValues[1], showHostHint: true);
                                if(_values[0] && mounted) {
                                    setState(() {
                                        _sonarrValues[1] = _values[1];
                                    });
                                }
                            }
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('API Key'),
                            subtitle: Elements.getSubtitle(_sonarrValues[2] == '' ? 'Not Set' : _sonarrValues[2], preventOverflow: true),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Sonarr API Key', prefill: _sonarrValues[2]);
                                if(_values[0] && mounted) {
                                    setState(() {
                                        _sonarrValues[2] = _values[1];
                                    });
                                }
                            }
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                    Elements.getButton('Test Connection', () async {
                        if(await SonarrAPI.testConnection(_sonarrValues)) {
                            Notifications.showSnackBar(_scaffoldKey, 'Connected successfully!');
                        } else {
                            Notifications.showSnackBar(_scaffoldKey, 'Connection test failed');
                        }
                    }),
                ],
                padding: Elements.getListViewPadding(),
            ),
        );
    }
}
