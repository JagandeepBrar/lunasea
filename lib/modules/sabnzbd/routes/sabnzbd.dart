import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SABnzbd extends StatefulWidget {
    static const ROUTE_NAME = '/sabnzbd';

    @override
    State<SABnzbd> createState() => _State();
}

class _State extends State<SABnzbd> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _pageController = PageController(initialPage: SABnzbdDatabaseValue.NAVIGATION_INDEX.data);
    String _profileState = Database.currentProfileObject.toString();
    SABnzbdAPI _api = SABnzbdAPI.from(Database.currentProfileObject);

    final List _refreshKeys = [
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
    ];

    @override
    void initState() {
        super.initState();
        Future.microtask(() => Provider.of<SABnzbdModel>(context, listen: false).navigationIndex = 0);
    }

    @override
    Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
            if(_scaffoldKey.currentState.isDrawerOpen) {
                //If the drawer is open, return true to close it
                return true;
            } else {
                //If the drawer isn't open, open the drawer
                _scaffoldKey.currentState.openDrawer();
                return false;
            }
        },
        child: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [LunaSeaDatabaseValue.ENABLED_PROFILE.key]),
            builder: (context, box, widget) {
                if(_profileState != Database.currentProfileObject.toString()) _refreshProfile();
                return Scaffold(
                    key: _scaffoldKey,
                    body: _body,
                    drawer: _drawer,
                    appBar: _appBar,
                    bottomNavigationBar: _bottomNavigationBar,
                );
            },
        ),
    );

    Widget get _drawer => LSDrawer(page: 'sabnzbd');

    Widget get _bottomNavigationBar => SABnzbdNavigationBar(pageController: _pageController);

    List<Widget> get _tabs => [
        SABnzbdQueue(refreshIndicatorKey: _refreshKeys[0]),
        SABnzbdHistory(refreshIndicatorKey: _refreshKeys[1]),
    ];

    Widget get _body => PageView(
        controller: _pageController,
        children: _api.enabled ? _tabs : List.generate(_tabs.length, (_) => LSNotEnabled('SABnzbd')),
        onPageChanged: _onPageChanged,
    );

    Widget get _appBar => LSAppBarDropdown(
        title: 'SABnzbd',
        profiles: Database.profilesBox.keys.fold([], (value, element) {
            if((Database.profilesBox.get(element) as ProfileHiveObject).sabnzbdEnabled)
                value.add(element);
            return value;
        }),
        actions: _api.enabled
            ? <Widget>[
                Selector<SABnzbdModel, bool>(
                    selector: (_, model) => model.error,
                    builder: (context, error, widget) => error
                        ? Container()
                        : SABnzbdAppBarStats(),
                ),
                LSIconButton(
                    icon: Icons.more_vert,
                    onPressed: () async => _handlePopup(),
                ),
            ]
            : null,
    );

    Future<void> _handlePopup() async {
        List<dynamic> values = await SABnzbdDialogs.globalSettings(context);
        if(values[0]) switch(values[1]) {
            case 'web_gui': _api.host.lsLinks_OpenLink(); break;
            case 'add_nzb': _addNZB(); break;
            case 'sort': _sort(); break;
            case 'clear_history': _clearHistory(); break;
            case 'complete_action': _completeAction(); break;
            case 'server_details': _serverDetails(); break;
            default: Logger.warning('SABnzbd', '_handlePopup', 'Unknown Case: ${values[1]}');
        }
    }

    Future<void> _serverDetails() async => Navigator.of(context).pushNamed(SABnzbdStatistics.ROUTE_NAME);

    Future<void> _completeAction() async {
        List values = await SABnzbdDialogs.changeOnCompleteAction(context);
        if(values[0]) SABnzbdAPI.from(Database.currentProfileObject).setOnCompleteAction(values[1])
        .then((_) => LSSnackBar(
            context: context,
            title: 'On Complete Action Set',
            message: values[2],
            type: SNACKBAR_TYPE.success,
        ))
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Set Complete Action',
            message: Constants.CHECK_LOGS_MESSAGE,
            type: SNACKBAR_TYPE.failure,
        ));
    }

    Future<void> _clearHistory() async {
        List values = await SABnzbdDialogs.clearAllHistory(context);
        if(values[0]) SABnzbdAPI.from(Database.currentProfileObject).clearHistory(values[1], values[2])
        .then((_) {
            LSSnackBar(
                context: context,
                title: 'History Cleared',
                message: values[3],
                type: SNACKBAR_TYPE.success,
            );
            _refreshAllPages();
        })
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Upload NZB',
            message: Constants.CHECK_LOGS_MESSAGE,
            type: SNACKBAR_TYPE.failure,
        ));
    }

    Future<void> _sort() async {
        List values = await SABnzbdDialogs.sortQueue(context);
        if(values[0]) await SABnzbdAPI.from(Database.currentProfileObject).sortQueue(values[1], values[2])
        .then((_) {
            LSSnackBar(
                context: context,
                title: 'Sorted Queue',
                message: values[3],
                type: SNACKBAR_TYPE.success,
            );
            (_refreshKeys[0] as GlobalKey<RefreshIndicatorState>)?.currentState?.show();
        })
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Sort Queue',
            message: Constants.CHECK_LOGS_MESSAGE,
            type: SNACKBAR_TYPE.failure,
        ));
    }

    Future<void> _addNZB() async {
        List values = await SABnzbdDialogs.addNZB(context);
        if(values[0]) switch(values[1]) {
            case 'link': _addByURL(); break;
            case 'file': _addByFile(); break;
            default: Logger.warning('SABnzbd', '_addNZB', 'Unknown Case: ${values[1]}');
        }
    }

    Future<void> _addByFile() async {
        File file = await FilePicker.getFile(type: FileType.any);
        if(file != null) {
            if(
                file.path.endsWith('.nzb') ||
                file.path.endsWith('.zip') ||
                file.path.endsWith('.rar') ||
                file.path.endsWith('.gz')
            ) {
                String data = await file.readAsString();
                String name = file.path.substring(file.path.lastIndexOf('/')+1, file.path.length);
                if(data != null) {
                    await _api.uploadFile(data, name)
                    .then((_) {
                        _refreshKeys[0]?.currentState?.show();
                        LSSnackBar(
                            context: context,
                            title: 'Uploaded NZB (File)',
                            message: name,
                            type: SNACKBAR_TYPE.success,
                        );
                    })
                    .catchError((_) {
                        LSSnackBar(
                            context: context,
                            title: 'Failed to Upload NZB',
                            message: Constants.CHECK_LOGS_MESSAGE,
                            type: SNACKBAR_TYPE.failure,
                        );
                    });
                }
            } else {
                LSSnackBar(
                    context: context,
                    title: 'Failed to Upload NZB',
                    message: 'The selected file is not valid',
                    type: SNACKBAR_TYPE.failure,
                );
            }
        }
    }

    Future<void> _addByURL() async {
        List values = await SABnzbdDialogs.addNZBUrl(context);
        if(values[0]) await _api.uploadURL(values[1])
        .then((_) => LSSnackBar(
            context: context,
            title: 'Uploaded NZB (URL)',
            message: values[1],
            type: SNACKBAR_TYPE.success,
        ))
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Upload NZB',
            message: Constants.CHECK_LOGS_MESSAGE,
            type: SNACKBAR_TYPE.failure,
        ));
    }

    void _onPageChanged(int index) => Provider.of<SABnzbdModel>(context, listen: false).navigationIndex = index;

    void _refreshProfile() {
        _api = SABnzbdAPI.from(Database.currentProfileObject);
        _profileState = Database.currentProfileObject.toString();
        _refreshAllPages();
    }

    void _refreshAllPages() {
        for(var key in _refreshKeys) key?.currentState?.show();
    }
}