import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lunasea/configuration/values.dart';
import 'package:lunasea/logic/clients/sabnzbd.dart';
import 'package:lunasea/logic/clients/sabnzbd/entry.dart';
import 'package:lunasea/pages/sabnzbd/subpages.dart';
import 'package:lunasea/pages/sabnzbd/subpages/statistics/statistics.dart';
import 'package:lunasea/core.dart';

class SABnzbd extends StatefulWidget {
    @override
    State<SABnzbd> createState() {
        return _State();
    }
}

class _State extends State<SABnzbd> {
    static final List _refreshKeys = [
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
    ];
    static final List _scaffoldKeys = [
        GlobalKey<ScaffoldState>(),
        GlobalKey<ScaffoldState>(),
    ];
    bool _paused = false;
    String _status = 'Connecting...';
    String _speed = '0.0 B/s';
    String _sizeLeft = '0.0 B';
    String _timeLeft = '0:00:00';
    int _speedLimit = 0;
    int _currIndex = 0;

    final List<String> _titles = [
        'Queue',
        'History',
    ];

    final List<Icon> _icons = [
        Icon(CustomIcons.queue),
        Icon(CustomIcons.history),
    ];

    void _navOnTap(int index) {
        if(mounted) {
            setState(() {
                _currIndex = index;
            });
        }
    }

    void _refreshStatus(SABnzbdStatusEntry entry) {
        if(entry != null && mounted) {
            setState(() {
                _speed = entry.currentSpeed;
                _sizeLeft = entry.remainingSize;
                _timeLeft = entry.timeLeft;
                _paused = entry.paused;
                _speedLimit = entry.speedlimit;
                _status = _paused ? 'Paused' : _speed == '0.0 B/s' ? 'Idle' : '$_speed';
            });
        } else if(mounted) {
            setState(() {
                _speed = '0.0 B/s';
                _sizeLeft = '0.0 B';
                _timeLeft = '0:00:00';
                _paused = false;
                _status = 'Error';
                _speedLimit = 0;
            });
        }
    }

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            body: Stack(
                children: <Widget>[
                    Offstage(
                        offstage: _currIndex != 0,
                        child: TickerMode(
                            enabled: _currIndex == 0,
                            child: SABnzbdQueue(
                                scaffoldKey: _scaffoldKeys[0],
                                refreshIndicatorKey: _refreshKeys[0],
                                refreshStatus: _refreshStatus,
                            ),
                        ),
                    ),
                    Offstage(
                        offstage: _currIndex != 1,
                        child: TickerMode(
                            enabled: _currIndex == 1,
                            child: SABnzbdHistory(
                                scaffoldKey: _scaffoldKeys[1],
                                refreshIndicatorKey: _refreshKeys[1],
                            ),
                        ),
                    )
                ],
            ),
            appBar: _buildAppBar(),
            drawer: Navigation.getDrawer('sabnzbd', context),
            bottomNavigationBar: Navigation.getBottomNavigationBar(_currIndex, _icons, _titles, _navOnTap),
        );
    }

    AppBar _buildAppBar() {
        return AppBar(
            title: Text(
                'SABnzbd',
                style: TextStyle(
                    letterSpacing: Constants.LETTER_SPACING,
                ),
            ),
            centerTitle: false,
            elevation: 0,
            backgroundColor: Color(Constants.SECONDARY_COLOR),
            actions: <Widget>[
                GestureDetector(
                    child: Center(
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.white54,
                                    letterSpacing: Constants.LETTER_SPACING,
                                ),
                                children: <TextSpan>[
                                    TextSpan(
                                        text: _status,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                            color: Color(Constants.ACCENT_COLOR),
                                        ),
                                    ),
                                    TextSpan(
                                        text: '\n${_timeLeft == '0:00:00' ? '―' : _timeLeft}\t\t•\t\t${_sizeLeft == '0.0 B' ? '―' : _sizeLeft}',
                                    ),
                                ],
                            ),
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            softWrap: false,
                            textAlign: TextAlign.right,
                        ),
                    ),
                    onTap: () async {
                        _handleSpeedPopup(context);
                    },
                ),
                IconButton(
                    icon: Elements.getIcon(Icons.more_vert),
                    tooltip: 'More Settings',
                    onPressed: () async {
                        _handlePopup(context);
                    },
                ),
            ],
        );
    }

    Future<void> _handlePopup(BuildContext context) async {
        List<dynamic> values = await SABnzbdDialogs.showSettingsPrompt(context);
        if(values[0]) {
            switch(values[1]) {
                case 'web_gui': {
                    List<dynamic> sabnzbdValues = Values.sabnzbdValues;
                    await Functions.openURL(sabnzbdValues[1]);
                    break;
                }
                case 'sort': {
                    values = await SABnzbdDialogs.showSortPrompt(context);
                    if(values[0]) {
                        if(await SABnzbdAPI.sortQueue(values[1], values[2])) {
                            _refreshKeys[0]?.currentState?.show();
                            Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Sorted queue');
                        } else {
                            Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Failed to sort queue');
                        }
                    }
                    break;
                }
                case 'add_nzb': {
                    values = await SABnzbdDialogs.showAddNZBPrompt(context);
                    if(values[0]) {
                        switch(values[1]) {
                            case 'file': {
                                await _handleNZBFile();
                                break;
                            }
                            case 'link': {
                                await _handleNZBLink();
                                break;
                            }
                        }
                    }
                    break;
                }
                case 'complete_action': {
                    values = await SABnzbdDialogs.showOnCompletePrompt(context);
                    if(values[0]) {
                        if(await SABnzbdAPI.setOnCompleteAction(values[1])) {
                            _refreshKeys[0]?.currentState?.show();
                            Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'On complete action set');
                        } else {
                            Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Failed to set on complete action');
                        }
                    }
                    break;
                }
                case 'server_details': {
                    _enterServerDetails();
                    break;
                }
                case 'clear_history': {
                    values = await SABnzbdDialogs.showClearHistoryPrompt(context);
                    if(values[0]) {
                        if(await SABnzbdAPI.clearHistory(values[1])) {
                            _refreshKeys[1]?.currentState?.show();
                            Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Cleared history');
                        } else {
                            Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Failed to clear history');
                        }
                    }
                    break;
                }
            }
        }
    }

    Future<void> _handleNZBLink() async {
        List<dynamic> values = await SABnzbdDialogs.showaddURLPrompt(context);
        if(values[0]) {
            if(await SABnzbdAPI.uploadURL(values[1])) {
                _refreshKeys[0]?.currentState?.show();
                Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Added NZB URL');
            } else {
                Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Failed to add NZB URL');
            }
        }
    }

    Future<void> _handleNZBFile() async {
        File file = await FilePicker.getFile(type: FileType.ANY);
        if(file != null) {
            if(file.path.endsWith('nzb') || file.path.endsWith('zip')) {
                String data = await file.readAsString();
                String name = file.path.substring(file.path.lastIndexOf('/')+1, file.path.length);
                if(data != null) {
                    if(await SABnzbdAPI.uploadFile(data, name)) {
                        _refreshKeys[0]?.currentState?.show();
                        Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Uploaded NZB file(s)');
                    } else {
                        Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Failed to upload NZB file(s)');
                    }
                }
            } else {
                Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'The selected file is not valid');
            }
        }
    }

    Future<void> _handleSpeedPopup(BuildContext context) async {
        List<dynamic> values = await SABnzbdDialogs.showSpeedPrompt(context, _speedLimit);
        if(values[0]) {
            switch(values[1]) {
                case -1: {
                    values = await SABnzbdDialogs.showCustomSpeedPrompt(context);
                    if(values[0]) {
                        if(await SABnzbdAPI.setSpeedLimit(values[1])) {
                            _speedLimit = values[1];
                            Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Speed limit set to ${values[1]}%');
                        } else {
                            Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Failed to set speed limit');
                        }
                    }
                    break;
                }
                default: {
                    if(await SABnzbdAPI.setSpeedLimit(values[1])) {
                        _speedLimit = values[1];
                        Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Speed limit set to ${values[1]}%');
                    } else {
                        Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Failed to set speed limit');
                    }
                    break;
                }
            }
        }
    }

    Future<void> _enterServerDetails() async {
        await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SABnzbdServerStatusStatistics(),
            ),
        );
    }
}
