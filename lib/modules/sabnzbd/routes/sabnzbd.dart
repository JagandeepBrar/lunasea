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
    LunaPageController _pageController;
    String _profileState = Database.currentProfileObject.toString();
    SABnzbdAPI _api = SABnzbdAPI.from(Database.currentProfileObject);

    final List _refreshKeys = [
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
    ];

    @override
    void initState() {
        super.initState();
        _pageController = LunaPageController(initialPage: SABnzbdDatabaseValue.NAVIGATION_INDEX.data);
    }

    @override
    Widget build(BuildContext context) {
        return LunaScaffold(
            scaffoldKey: _scaffoldKey,
            body: _body(),
            drawer: _drawer(),
            appBar: _appBar(),
            bottomNavigationBar: _bottomNavigationBar(),
            extendBodyBehindAppBar: false,
            extendBody: false,
            onProfileChange: (_) {
                if(_profileState != Database.currentProfileObject.toString()) _refreshProfile();
            },
        );
    }

    Widget _drawer() => LunaDrawer(page: LunaModule.SABNZBD.key);

    Widget _bottomNavigationBar() {
        if(_api.enabled) return SABnzbdNavigationBar(pageController: _pageController);
        return null;
    }

    Widget _appBar() {
        List<String> profiles = Database.profilesBox.keys.fold([], (value, element) {
            if(Database.profilesBox.get(element)?.sabnzbdEnabled ?? false) value.add(element);
            return value;
        });
        List<Widget> actions;
        if(_api.enabled) actions = [
            Selector<SABnzbdState, bool>(
                selector: (_, model) => model.error,
                builder: (context, error, widget) => error
                    ? Container()
                    : SABnzbdAppBarStats(),
            ),
            LunaIconButton(
                icon: Icons.more_vert,
                onPressed: () async => _handlePopup(),
            ),
        ];
        return LunaAppBar.dropdown(
            title: LunaModule.SABNZBD.name,
            useDrawer: true,
            profiles: profiles,
            actions: actions,
            pageController: _pageController,
            scrollControllers: SABnzbdNavigationBar.scrollControllers,
        );
    }

    Widget _body() {
        if(!_api.enabled) return LunaMessage.moduleNotEnabled(
            context: context,
            module: LunaModule.SABNZBD.name,
        );
        return PageView(
            controller: _pageController,
            children: [
                SABnzbdQueue(
                    refreshIndicatorKey: _refreshKeys[0],
                ),
                SABnzbdHistory(
                    refreshIndicatorKey: _refreshKeys[1],
                ),
            ],
        );
    }

    Future<void> _handlePopup() async {
        List<dynamic> values = await SABnzbdDialogs.globalSettings(context);
        if(values[0]) switch(values[1]) {
            case 'web_gui':
                ProfileHiveObject profile = Database.currentProfileObject;
                await profile.sabnzbdHost?.lunaOpenGenericLink(headers: profile.sabnzbdHeaders);
                break;
            case 'add_nzb': _addNZB(); break;
            case 'sort': _sort(); break;
            case 'clear_history': _clearHistory(); break;
            case 'complete_action': _completeAction(); break;
            case 'server_details': _serverDetails(); break;
            default: LunaLogger().warning('SABnzbd', '_handlePopup', 'Unknown Case: ${values[1]}');
        }
    }

    Future<void> _serverDetails() async => Navigator.of(context).pushNamed(SABnzbdStatistics.ROUTE_NAME);

    Future<void> _completeAction() async {
        List values = await SABnzbdDialogs.changeOnCompleteAction(context);
        if(values[0]) SABnzbdAPI.from(Database.currentProfileObject).setOnCompleteAction(values[1])
        .then((_) => showLunaSuccessSnackBar(
            title: 'On Complete Action Set',
            message: values[2],
        ))
        .catchError((error) => showLunaErrorSnackBar(
            title: 'Failed to Set Complete Action',
            error: error,
        ));
    }

    Future<void> _clearHistory() async {
        List values = await SABnzbdDialogs.clearAllHistory(context);
        if(values[0]) SABnzbdAPI.from(Database.currentProfileObject).clearHistory(values[1], values[2])
        .then((_) {
            showLunaSuccessSnackBar(
                title: 'History Cleared',
                message: values[3],
            );
            _refreshAllPages();
        })
        .catchError((error) => showLunaErrorSnackBar(
            title: 'Failed to Upload NZB',
            error: error,
        ));
    }

    Future<void> _sort() async {
        List values = await SABnzbdDialogs.sortQueue(context);
        if(values[0]) await SABnzbdAPI.from(Database.currentProfileObject).sortQueue(values[1], values[2])
        .then((_) {
            showLunaSuccessSnackBar(
                title: 'Sorted Queue',
                message: values[3],
            );
            (_refreshKeys[0] as GlobalKey<RefreshIndicatorState>)?.currentState?.show();
        })
        .catchError((error) => showLunaErrorSnackBar(
            title: 'Failed to Sort Queue',
            error: error,
        ));
    }

    Future<void> _addNZB() async {
        List values = await SABnzbdDialogs.addNZB(context);
        if(values[0]) switch(values[1]) {
            case 'link': _addByURL(); break;
            case 'file': _addByFile(); break;
            default: LunaLogger().warning('SABnzbd', '_addNZB', 'Unknown Case: ${values[1]}');
        }
    }

    Future<void> _addByFile() async {
        try {
            FilePickerResult _file = await FilePicker.platform.pickFiles(
                type: FileType.any,
                allowMultiple: false,
                allowCompression: false,
                withData: true,
            );
            if(_file == null) return;
            if(
                _file.files[0].extension == 'nzb' ||
                _file.files[0].extension == 'zip' ||
                _file.files[0].extension == 'rar' ||
                _file.files[0].extension == 'gz'
            ) {
                String _data = String.fromCharCodes(_file.files[0].bytes);
                String _name = _file.files[0].name;
                if(_data != null) await _api.uploadFile(_data, _name)
                .then((value) {
                    _refreshKeys[0]?.currentState?.show();
                    showLunaSuccessSnackBar(
                        title: 'Uploaded NZB (File)',
                        message: _name,
                    );
                })
                .catchError((error, stack) => showLunaErrorSnackBar(
                    title: 'Failed to Upload NZB',
                    message: LunaLogger.checkLogsMessage,
                    error: error,
                ));
            } else {
                showLunaErrorSnackBar(
                    title: 'Failed to Upload NZB',
                    message: 'The selected file is not valid',
                );
            }
        } catch (error, stack) {
            LunaLogger().error('Failed to add NZB by file', error, stack);
            showLunaErrorSnackBar(
                title: 'Failed to Upload NZB',
                error: error,
            );
        }
    }

    Future<void> _addByURL() async {
        List values = await SABnzbdDialogs.addNZBUrl(context);
        if(values[0]) await _api.uploadURL(values[1])
        .then((_) => showLunaSuccessSnackBar(
            title: 'Uploaded NZB (URL)',
            message: values[1],
        ))
        .catchError((error) => showLunaErrorSnackBar(
            title: 'Failed to Upload NZB',
            error: error,
        ));
    }

    void _refreshProfile() {
        _api = SABnzbdAPI.from(Database.currentProfileObject);
        _profileState = Database.currentProfileObject.toString();
        _refreshAllPages();
    }

    void _refreshAllPages() {
        for(var key in _refreshKeys) key?.currentState?.show();
    }
}