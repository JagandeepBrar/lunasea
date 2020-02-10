import 'package:flutter/material.dart';
import 'package:lunasea/configuration/values.dart';
import 'package:lunasea/logic/automation/radarr.dart';
import 'package:lunasea/core.dart';

class Radarr extends StatefulWidget {
    @override
    State<Radarr> createState() {
        return _State();
    }
}

class _State extends State<Radarr> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    List<dynamic> _radarrValues;

    @override
    void initState() {
        super.initState();
        _refreshData();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            body: _radarrSettings(),
            floatingActionButton: _buildFloatingActionButton(),
        );
    }

    void _refreshData() {
        if(mounted) {
            setState(() {
                _radarrValues = List.from(Values.radarrValues);
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
                await Values.setRadarr(_radarrValues);
                Notifications.showSnackBar(_scaffoldKey, 'Settings saved');
            },
        );
    }

    Widget _radarrSettings() {
        return Scrollbar(
            child: ListView(
                children: <Widget>[
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Enable Radarr'),
                            trailing: Switch(
                                value: _radarrValues[0],
                                onChanged: (value) {
                                    if(mounted) {
                                        setState(() {
                                            _radarrValues[0] = value;
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
                            subtitle: Elements.getSubtitle(_radarrValues[1] == '' ? 'Not Set' : _radarrValues[1], preventOverflow: true),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Radarr Host', prefill: _radarrValues[1], showHostHint: true);
                                if(_values[0] && mounted) {
                                    setState(() {
                                        _radarrValues[1] = _values[1];
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
                            subtitle: Elements.getSubtitle(_radarrValues[2] == '' ? 'Not Set' : '••••••••••••', preventOverflow: true),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Radarr API Key', prefill: _radarrValues[2]);
                                if(_values[0] && mounted) {
                                    setState(() {
                                        _radarrValues[2] = _values[1];
                                    });
                                }
                            }
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                    Elements.getButton('Test Connection', () async {
                        if(await RadarrAPI.testConnection(_radarrValues)) {
                            await Values.setRadarr(_radarrValues);
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
