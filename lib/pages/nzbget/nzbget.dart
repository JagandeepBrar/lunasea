import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/configuration/values.dart';
import 'package:lunasea/logic/clients/nzbget.dart';
import 'package:lunasea/pages/nzbget/subpages.dart';
import 'package:lunasea/pages/nzbget/subpages/statistics/statistics.dart';
import 'package:lunasea/system/constants.dart';
import 'package:lunasea/system/functions.dart';
import 'package:lunasea/system/ui.dart';

class NZBGet extends StatefulWidget {
    @override
    State<NZBGet> createState() {
        return _State();
    }
}

class _State extends State<NZBGet> {
    static final List _refreshKeys = [
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
    ];
    static final List _scaffoldKeys = [
        GlobalKey<ScaffoldState>(),
        GlobalKey<ScaffoldState>(),
    ];
    final List<String> _titles = [
        'Queue',
        'History',
    ];
    bool _paused = false;
    String _status = 'Connecting...';
    String _speed = '0.0 B/s';
    String _sizeLeft = '0.0 B';
    String _timeLeft = '0:00:00';
    String _speedlimit = 'Unknown';
    int _currIndex = 0;

    final List<Icon> _icons = [
        Icon(Icons.queue),
        Icon(Icons.history),
    ];

    void _navOnTap(int index) {
        if(mounted) {
            setState(() {
                _currIndex = index;
            });
        }
    }

    void _refreshStatus(NZBGetStatusEntry entry) {
        if(entry != null && mounted) {
            setState(() {
                _speed = entry.currentSpeed;
                _sizeLeft = entry.remainingString;
                _timeLeft = entry.timeLeft;
                _speedlimit = entry.speedlimitString;
                _paused = entry.paused;
                _status = _paused ? 'Paused' : _speed == '0.0 B/s' ? 'Idle' : '$_speed';
            });
        } else if(mounted) {
            setState(() {
                _speed = '0.0 B/s';
                _sizeLeft = '0.0 B';
                _timeLeft = '0:00:00';
                _speedlimit = 'Unknown';
                _paused = false;
                _status = 'Error';
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
                            child: NZBGetQueue(
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
                            child: NZBGetHistory(
                                scaffoldKey: _scaffoldKeys[1],
                                refreshIndicatorKey: _refreshKeys[1],
                            ),
                        ),
                    )
                ],
            ),
            appBar: _buildAppBar(),
            drawer: Navigation.getDrawer('nzbget', context),
            bottomNavigationBar: Navigation.getBottomNavigationBar(_currIndex, _icons, _titles, _navOnTap),
        );
    }

    AppBar _buildAppBar() {
        return AppBar(
            title: Text(
                'NZBGet',
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
        List<dynamic> values = await NZBGetDialogs.showSettingsPrompt(context);
        if(values[0]) {
            switch(values[1]) {
                case 'web_gui': {
                    List<dynamic> nzbgetValues = Values.nzbgetValues;
                    await Functions.openURL(nzbgetValues[1]);
                    break;
                }
                case 'sort': {
                    values = await NZBGetDialogs.showSortPrompt(context);
                    if(values[0]) {
                        if(await NZBGetAPI.sortQueue(values[1])) {
                            _refreshKeys[0]?.currentState?.show();
                            Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Sorted queue');
                        } else {
                            Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Failed to sort queue');
                        }
                    }
                    break;
                }
                case 'add_nzb': {
                    values = await NZBGetDialogs.showAddNZBPrompt(context);
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
                case 'server_details': {
                    await _enterServerStatistics();
                    break;
                }
            }
        }
    }

    Future<void> _handleSpeedPopup(BuildContext context) async {
        List<dynamic> values = await NZBGetDialogs.showSpeedPrompt(context, _speedlimit);
        if(values[0]) {
            switch(values[1]) {
                case -1: {
                    values = await NZBGetDialogs.showCustomSpeedPrompt(context);
                    if(values[0]) {
                        if(await NZBGetAPI.setSpeedLimit(values[1])) {
                            Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Speed limit set');
                        } else {
                            Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Failed to set speed limit');
                        }
                    }
                    break;
                }
                default: {
                    if(values[0]) {
                        if(await NZBGetAPI.setSpeedLimit(values[1])) {
                            Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Speed limit set');
                        } else {
                            Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Failed to set speed limit');
                        }
                    }
                    break;
                }
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
                    if(await NZBGetAPI.uploadFile(data, name)) {
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

    Future<void> _handleNZBLink() async {
        List<dynamic> values = await SABnzbdDialogs.showaddURLPrompt(context);
        if(values[0]) {
            if(await NZBGetAPI.uploadURL(values[1])) {
                _refreshKeys[0]?.currentState?.show();
                Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Added NZB URL');
            } else {
                Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Failed to add NZB URL');
            }
        }
    }

    Future<void> _enterServerStatistics() async {
        await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => NZBGetStatistics(),
            ),
        );
    }
}
