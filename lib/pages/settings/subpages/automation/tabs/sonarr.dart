import 'package:flutter/material.dart';
import 'package:lunasea/configuration/values.dart';
import 'package:lunasea/logic/automation/sonarr.dart';
import 'package:lunasea/core.dart';

class Sonarr extends StatefulWidget {
    @override
    State<Sonarr> createState() {
        return _State();
    }
}

class _State extends State<Sonarr> {
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
        return FloatingActionButton.extended(
            label: Text(
                'Save',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: Constants.LETTER_SPACING,
                ),
            ),
            heroTag: null,
            tooltip: 'Save Settings',
            icon: Elements.getIcon(Icons.save),
            backgroundColor: Colors.red,
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
                            subtitle: Elements.getSubtitle(_sonarrValues[2] == '' ? 'Not Set' : '••••••••••••', preventOverflow: true),
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
                            await Values.setSonarr(_sonarrValues);
                            Notifications.showSnackBar(_scaffoldKey, 'Connected successfully, settings saved!');
                            
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
