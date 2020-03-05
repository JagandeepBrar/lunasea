import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/routes/sabnzbd/subpages.dart';
import 'package:lunasea/routes/sabnzbd/subpages/statistics/statistics.dart';
import 'package:lunasea/widgets/ui.dart';

class SABnzbd extends StatefulWidget {
    @override
    State<SABnzbd> createState() {
        return _State();
    }
}

class _State extends State<SABnzbd> {
    final List _scaffoldKeys = [
        GlobalKey<ScaffoldState>(),
        GlobalKey<ScaffoldState>(),
    ];
    int _currIndex = 0;
    String _profileState = Database.currentProfileObject.toString();
    SABnzbdAPI _api = SABnzbdAPI.from(Database.currentProfileObject);

    final List _refreshKeys = [
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
    ];

    final List<String> _navbarTitles = [
        'Queue',
        'History',
    ];

    final List<Icon> _navbarIcons = [
        Icon(CustomIcons.queue),
        Icon(CustomIcons.history),
    ];

    bool _paused = false;
    String _status = 'Connecting...';
    String _speed = '0.0 B/s';
    String _sizeLeft = '0.0 B';
    String _timeLeft = '0:00:00';
    int _speedLimit = 0;

    @override
    Widget build(BuildContext context) {
        return ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: ['profile']),
            builder: (context, box, widget) {
                if(_profileState != Database.currentProfileObject.toString()) _refreshProfile();
                return Scaffold(
                    body: _body,
                    drawer: _drawer,
                    appBar: _appBar,
                    bottomNavigationBar: _bottomNavigationBar,
                );
            },
        );
    }

    Widget get _drawer => LSDrawer(page: 'sabnzbd');

    Widget get _bottomNavigationBar => LSBottomNavigationBar(
        index: _currIndex,
        icons: _navbarIcons,
        titles: _navbarTitles,
        onTap: _navOnTap,
    );

    Widget get _body => Stack(
        children: List.generate(_tabs.length, (index) => Offstage(
            offstage: _currIndex != index,
            child: TickerMode(
                enabled: _currIndex == index,
                child: _api.enabled
                    ? _tabs[index]
                    : LSNotEnabled('SABnzbd'),
            ),
        )),
    );

    Widget get _appBar => LSAppBar(
        title: 'SABnzbd',
        actions: _api.enabled
            ? <Widget>[
                GestureDetector(
                    child: Center(
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: Colors.white54,
                                    letterSpacing: Constants.UI_LETTER_SPACING,
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
            ]
            : null,
    );

    List<Widget> get _tabs => [
        SABnzbdQueue(
            scaffoldKey: _scaffoldKeys[0],
            refreshIndicatorKey: _refreshKeys[0],
            refreshStatus: _refreshStatus,
        ),
        SABnzbdHistory(
            scaffoldKey: _scaffoldKeys[1],
            refreshIndicatorKey: _refreshKeys[1],
        ),
    ];

    Future<void> _handlePopup(BuildContext context) async {
        List<dynamic> values = await SABnzbdDialogs.showSettingsPrompt(context);
        if(values[0]) {
            switch(values[1]) {
                case 'web_gui': await _api.host?.toString()?.lsLinks_OpenLink(); break;
                case 'sort': {
                    values = await SABnzbdDialogs.showSortPrompt(context);
                    if(values[0]) {
                        if(await _api.sortQueue(values[1], values[2])) {
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
                            case 'file': await _handleNZBFile(); break;
                            case 'link': await _handleNZBLink(); break;
                        }
                    }
                    break;
                }
                case 'complete_action': {
                    values = await SABnzbdDialogs.showOnCompletePrompt(context);
                    if(values[0]) {
                        if(await _api.setOnCompleteAction(values[1])) {
                            _refreshKeys[0]?.currentState?.show();
                            Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'On complete action set');
                        } else {
                            Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Failed to set on complete action');
                        }
                    }
                    break;
                }
                case 'server_details': _enterServerDetails(); break;
                case 'clear_history': {
                    values = await SABnzbdDialogs.showClearHistoryPrompt(context);
                    if(values[0]) {
                        if(await _api.clearHistory(values[1])) {
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
            if(await _api.uploadURL(values[1])) {
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
                    if(await _api.uploadFile(data, name)) {
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
                        if(await _api.setSpeedLimit(values[1])) {
                            _speedLimit = values[1];
                            Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Speed limit set to ${values[1]}%');
                        } else {
                            Notifications.showSnackBar(_scaffoldKeys[_currIndex], 'Failed to set speed limit');
                        }
                    }
                    break;
                }
                default: {
                    if(await _api.setSpeedLimit(values[1])) {
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

    Future<void> _enterServerDetails() async {
        await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SABnzbdServerStatusStatistics(),
            ),
        );
    }

    void _navOnTap(int index) {
        if(mounted) setState(() {
            _currIndex = index;
        });
    }

    void _refreshProfile() {
        _api = SABnzbdAPI.from(Database.currentProfileObject);
        _profileState = Database.currentProfileObject.toString();
        _refreshAllPages();
    }

    void _refreshAllPages() {
        for(var key in _refreshKeys) {
            key?.currentState?.show();
        }
    }
}
