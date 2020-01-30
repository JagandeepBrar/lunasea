import 'package:flutter/material.dart';
import 'package:lunasea/configuration/values.dart';
import 'package:lunasea/logic/clients/sabnzbd.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/ui.dart';

class SABnzbd extends StatefulWidget {
    @override
    State<SABnzbd> createState() {
        return _State();
    }
}

class _State extends State<SABnzbd> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    List<dynamic> _sabnzbdValues;

    @override
    void initState() {
        super.initState();
        _refreshData();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            key: _scaffoldKey,
            body: _sabnzbdSettings(),
            floatingActionButton: _buildFloatingActionButton(),
        );
    }

    void _refreshData() {
        if(mounted) {
            setState(() {
                _sabnzbdValues = List.from(Values.sabnzbdValues);
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
                await Values.setSabnzbd(_sabnzbdValues);
                Notifications.showSnackBar(_scaffoldKey, 'Settings saved');
            },
        );
    }

    Widget _sabnzbdSettings() {
        return Scrollbar(
            child: ListView(
                children: <Widget>[
                    Card(
                        child: ListTile(
                            title: Elements.getTitle('Enable SABnzbd'),
                            trailing: Switch(
                                value: _sabnzbdValues[0],
                                onChanged: (value) {
                                    if(mounted) {
                                        setState(() {
                                            _sabnzbdValues[0] = value;
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
                            subtitle: Elements.getSubtitle(_sabnzbdValues[1] == '' ? 'Not Set' : _sabnzbdValues[1], preventOverflow: true),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'SABnzbd Host', prefill: _sabnzbdValues[1], showHostHint: true);
                                if(_values[0] && mounted) {
                                    setState(() {
                                        _sabnzbdValues[1] = _values[1];
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
                            subtitle: Elements.getSubtitle(_sabnzbdValues[2] == '' ? 'Not Set' : '••••••••••••', preventOverflow: true),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.arrow_forward_ios),
                                onPressed: null,
                            ),
                            onTap: () async {
                                List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'SABnzbd API Key', prefill: _sabnzbdValues[2]);
                                if(_values[0] && mounted) {
                                    setState(() {
                                        _sabnzbdValues[2] = _values[1];
                                    });
                                }
                            }
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    ),
                    Elements.getButton('Test Connection', () async {
                        if(await SABnzbdAPI.testConnection(_sabnzbdValues)) {
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
