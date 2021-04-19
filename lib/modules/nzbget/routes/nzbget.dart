import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';

class NZBGet extends StatefulWidget {
    static const ROUTE_NAME = '/nzbget';

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<NZBGet> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    LunaPageController _pageController;
    String _profileState = Database.currentProfileObject.toString();
    NZBGetAPI _api = NZBGetAPI.from(Database.currentProfileObject);

    final List _refreshKeys = [
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
    ];

    @override
    void initState() {
        super.initState();
        _pageController = LunaPageController(initialPage: NZBGetDatabaseValue.NAVIGATION_INDEX.data);
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

    Widget _drawer() => LunaDrawer(page: LunaModule.NZBGET.key);

    Widget _bottomNavigationBar() {
        if(_api.enabled) return NZBGetNavigationBar(pageController: _pageController);
        return null;
    }

    Widget _appBar() {
        List<String> profiles = Database.profilesBox.keys.fold([], (value, element) {
            if(Database.profilesBox.get(element)?.nzbgetEnabled ?? false) value.add(element);
            return value;
        });
        List<Widget> actions;
        if(_api.enabled) actions = [
            Selector<NZBGetState, bool>(
                selector: (_, model) => model.error,
                builder: (context, error, widget) => error
                    ? Container()
                    : NZBGetAppBarStats(),
            ),
            LunaIconButton(
                icon: Icons.more_vert,
                onPressed: () async => _handlePopup(),
            ),
        ];
        return LunaAppBar.dropdown(
            title: LunaModule.NZBGET.name,
            useDrawer: true,
            profiles: profiles,
            actions: actions,
            pageController: _pageController,
            scrollControllers: NZBGetNavigationBar.scrollControllers,
        );
    }

    Widget _body() {
        if(!_api.enabled) return LunaMessage.moduleNotEnabled(
            context: context,
            module: LunaModule.NZBGET.name,
        );
        return PageView(
            controller: _pageController,
            children: [
                NZBGetQueue(
                    refreshIndicatorKey: _refreshKeys[0],
                ),
                NZBGetHistory(
                    refreshIndicatorKey: _refreshKeys[1],
                ),
            ],
        );
    }

    Future<void> _handlePopup() async {
        List<dynamic> values = await NZBGetDialogs.globalSettings(context);
        if(values[0]) switch(values[1]) {
            case 'web_gui':
                ProfileHiveObject profile = Database.currentProfileObject;
                await profile.nzbgetHost?.lunaOpenGenericLink(headers: profile.nzbgetHeaders);
                break;
            case 'add_nzb': _addNZB(); break;
            case 'sort': _sort(); break;
            case 'server_details': _serverDetails(); break;
            default: LunaLogger().warning('NZBGet', '_handlePopup', 'Unknown Case: ${values[1]}');
        }
    }

    Future<void> _addNZB() async {
        List values = await NZBGetDialogs.addNZB(context);
        if(values[0]) switch(values[1]) {
            case 'link': _addByURL(); break;
            case 'file': _addByFile(); break;
            default: LunaLogger().warning('NZBGet', '_addNZB', 'Unknown Case: ${values[1]}');
        }
    }

    Future<void> _addByURL() async {
        List values = await NZBGetDialogs.addNZBUrl(context);
        if(values[0]) await _api.uploadURL(values[1])
        .then((_) => showLunaSuccessSnackBar(title: 'Uploaded NZB (URL)', message: values[1]))
        .catchError((error) => showLunaErrorSnackBar(title: 'Failed to Upload NZB', error: error));
    }

    Future<void> _addByFile() async {
        try {
            File _file = await LunaFileSystem().import(context, ['nzb']);
            if(_file != null) {
                List<int> _data = _file.readAsBytesSync();
                String _name = _file.path.substring(_file.path.lastIndexOf('/')+1);
                if(_data?.isNotEmpty ?? false) await _api.uploadFile(_data, _name)
                .then((value) {
                    _refreshKeys[0]?.currentState?.show();
                    showLunaSuccessSnackBar(
                        title: 'Uploaded NZB (File)',
                        message: _name,
                    );
                });
            } else {
                showLunaErrorSnackBar(
                    title: 'Failed to Upload NZB',
                    message: 'Please select a valid file type',
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

    Future<void> _sort() async {
        List values = await NZBGetDialogs.sortQueue(context);
        if(values[0]) await _api.sortQueue(values[1])
        .then((_) {
            _refreshKeys[0]?.currentState?.show();
            showLunaSuccessSnackBar(title: 'Sorted Queue', message: (values[1] as NZBGetSort).name);
        })
        .catchError((error) => showLunaErrorSnackBar(title: 'Failed to Sort Queue', error: error));
    }

    Future<void> _serverDetails() async => Navigator.of(context).pushNamed(NZBGetStatistics.ROUTE_NAME);

    void _refreshProfile() {
        _api = NZBGetAPI.from(Database.currentProfileObject);
        _profileState = Database.currentProfileObject.toString();
        _refreshAllPages();
    }

    void _refreshAllPages() {
        for(var key in _refreshKeys) key?.currentState?.show();
    }
}