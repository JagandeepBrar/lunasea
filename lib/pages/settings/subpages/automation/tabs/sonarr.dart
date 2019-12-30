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
        setState(() {
            _sonarrValues = List.from(Values.sonarrValues);
        });
    }

    Widget _buildFloatingActionButton() {
        return FloatingActionButton(
            heroTag: null,
            tooltip: 'Test & Save',
            child: Elements.getIcon(Icons.save),
            onPressed: () async {
                if(await SonarrAPI.testConnection(_sonarrValues)) {
                    await Values.setSonarr(_sonarrValues);
                    _refreshData();
                    Notifications.showSnackBar(_scaffoldKey, 'Settings saved');
                } else {
                    Notifications.showSnackBar(_scaffoldKey, 'Connection test failed: Settings not saved');
                }
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
                                    setState(() {
                                        _sonarrValues[0] = value;
                                    });
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
                                List<dynamic> _values = await SystemDialogs.showEditTextPrompt(context, 'Sonarr Host', prefill: _sonarrValues[1]);
                                if(_values[0]) {
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
                                if(_values[0]) {
                                    setState(() {
                                        _sonarrValues[2] = _values[1];
                                    });
                                }
                            }
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
