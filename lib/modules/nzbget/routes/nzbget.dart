import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../nzbget.dart';

class NZBGet extends StatefulWidget {
    static const ROUTE_NAME = '/nzbget';

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<NZBGet> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final _pageController = PageController();
    String _profileState = Database.currentProfileObject.toString();
    NZBGetAPI _api = NZBGetAPI.from(Database.currentProfileObject);

    final List _refreshKeys = [
        GlobalKey<RefreshIndicatorState>(),
        GlobalKey<RefreshIndicatorState>(),
    ];

    @override
    void initState() {
        super.initState();
        Future.microtask(() => Provider.of<NZBGetModel>(context, listen: false).navigationIndex = 0);
    }

    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: ['profile']),
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
    );

    Widget get _drawer => LSDrawer(page: 'nzbget');

    Widget get _bottomNavigationBar => NZBGetNavigationBar(pageController: _pageController);

    List<Widget> get _tabs => [
        NZBGetQueue(refreshIndicatorKey: _refreshKeys[0]),
        NZBGetHistory(refreshIndicatorKey: _refreshKeys[1]),
    ];

    Widget get _body => PageView(
        controller: _pageController,
        children: _api.enabled ? _tabs : List.generate(_tabs.length, (_) => LSNotEnabled('NZBGet')),
        onPageChanged: _onPageChanged,
    );

    Widget get _appBar => LSAppBar(
        title: 'NZBGet',
        actions: _api.enabled
            ? <Widget>[
                Selector<NZBGetModel, bool>(
                    selector: (_, model) => model.error,
                    builder: (context, error, widget) => error
                        ? Container()
                        : NZBGetAppBarStats(),
                ),
                LSIconButton(
                    icon: Icons.more_vert,
                    onPressed: () async => _handlePopup(),
                ),
            ]
            : null,
    );

    Future<void> _handlePopup() async {
        List<dynamic> values = await LSDialogNZBGet.showSettingsPrompt(context);
        if(values[0]) switch(values[1]) {
            case 'web_gui': _api.host.lsLinks_OpenLink(); break;
            case 'add_nzb': _addNZB(); break;
            case 'sort': _sort(); break;
            case 'server_details': _serverDetails(); break;
            default: Logger.warning('NZBGet', '_handlePopup', 'Unknown Case: ${values[1]}');
        }
    }

    Future<void> _addNZB() async {
        List values = await LSDialogNZBGet.showAddNZBPrompt(context);
        if(values[0]) switch(values[1]) {
            case 'link': _addByURL(); break;
            case 'file': _addByFile(); break;
            default: Logger.warning('NZBGet', '_addNZB', 'Unknown Case: ${values[1]}');
        }
    }

    Future<void> _addByURL() async {
        List values = await LSDialogNZBGet.showaddURLPrompt(context);
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

    Future<void> _addByFile() async {
        File file = await FilePicker.getFile(type: FileType.any);
        if(file != null) {
            if(file.path.endsWith('nzb') || file.path.endsWith('zip')) {
                String data = await file.readAsString();
                String name = file.path.substring(file.path.lastIndexOf('/')+1, file.path.length);
                if(data != null) {
                    if(await _api.uploadFile(data, name)) {
                        _refreshKeys[0]?.currentState?.show();
                        LSSnackBar(
                            context: context,
                            title: 'Uploaded NZB (File)',
                            message: name,
                            type: SNACKBAR_TYPE.success,
                        );
                    } else {
                        LSSnackBar(
                            context: context,
                            title: 'Failed to Upload NZB',
                            message: Constants.CHECK_LOGS_MESSAGE,
                            type: SNACKBAR_TYPE.failure,
                        );
                    }
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

    Future<void> _sort() async {
        List values = await LSDialogNZBGet.showSortPrompt(context);
        if(values[0]) await _api.sortQueue(values[1])
        .then((_) {
            _refreshKeys[0]?.currentState?.show();
            LSSnackBar(
                context: context,
                title: 'Sorted Queue',
                message: (values[1] as NZBGetSort).name,
                type: SNACKBAR_TYPE.success,
            );
        })
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Sort Queue',
            message: Constants.CHECK_LOGS_MESSAGE,
            type: SNACKBAR_TYPE.failure,
        ));
    }

    Future<void> _serverDetails() async => Navigator.of(context).pushNamed(NZBGetStatistics.ROUTE_NAME);

    void _onPageChanged(int index) => Provider.of<NZBGetModel>(context, listen: false).navigationIndex = index;

    void _refreshProfile() {
        _api = NZBGetAPI.from(Database.currentProfileObject);
        _profileState = Database.currentProfileObject.toString();
        _refreshAllPages();
    }

    void _refreshAllPages() {
        for(var key in _refreshKeys) key?.currentState?.show();
    }
}