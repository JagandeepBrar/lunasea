import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system.dart';
import 'package:lunasea/widgets/ui.dart';

class Lidarr extends StatefulWidget {
    @override
    State<Lidarr> createState() {
        return _State();
    }
}

class _State extends State<Lidarr> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    List<dynamic> _lidarrValues;

    @override
    void initState() {
        super.initState();
        _refreshData();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            body: _lidarrSettings(),
            floatingActionButton: _buildFloatingActionButton(),
        );
    }

    void _refreshData() {
        if(mounted) {
            setState(() {
                _lidarrValues = List.from(Values.lidarrValues);
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
                await Values.setLidarr(_lidarrValues);
                Notifications.showSnackBar(_scaffoldKey, 'Settings saved');
            },
        );
    }

    Widget _lidarrSettings() {
        return Scrollbar(
            child: ListView(
                children: <Widget>[
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Enable Lidarr'),
                            trailing: Switch(
                                value: _lidarrValues[0],
                                onChanged: (value) {
                                    if(mounted) {
                                        setState(() {
                                            _lidarrValues[0] = value;
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
                            subtitle: Elements.getSubtitle(_lidarrValues[1] == '' ? 'Not Set' : _lidarrValues[1], preventOverflow: true),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Lidarr Host', prefill: _lidarrValues[1], showHostHint: true);
                                if(_values[0] && mounted) {
                                    setState(() {
                                        _lidarrValues[1] = _values[1];
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
                            subtitle: Elements.getSubtitle(_lidarrValues[2] == '' ? 'Not Set' : '••••••••••••', preventOverflow: true),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Lidarr API Key', prefill: _lidarrValues[2]);
                                if(_values[0] && mounted) {
                                    setState(() {
                                        _lidarrValues[2] = _values[1];
                                    });
                                }
                            }
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                    Elements.getButton('Test Connection', () async {
                        if(await LidarrAPI.testConnection(_lidarrValues)) {
                            await Values.setLidarr(_lidarrValues);
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
