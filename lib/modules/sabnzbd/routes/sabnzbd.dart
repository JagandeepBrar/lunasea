import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/tables/sabnzbd.dart';
import 'package:lunasea/extensions/string/links.dart';
import 'package:lunasea/modules/sabnzbd.dart';
import 'package:lunasea/router/routes/sabnzbd.dart';
import 'package:lunasea/system/filesystem/file.dart';
import 'package:lunasea/system/filesystem/filesystem.dart';

class SABnzbdRoute extends StatefulWidget {
  final bool showDrawer;

  const SABnzbdRoute({
    Key? key,
    this.showDrawer = true,
  }) : super(key: key);

  @override
  State<SABnzbdRoute> createState() => _State();
}

class _State extends State<SABnzbdRoute> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  LunaPageController? _pageController;
  String _profileState = LunaProfile.current.toString();
  SABnzbdAPI _api = SABnzbdAPI.from(LunaProfile.current);

  final List _refreshKeys = [
    GlobalKey<RefreshIndicatorState>(),
    GlobalKey<RefreshIndicatorState>(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = LunaPageController(
        initialPage: SABnzbdDatabase.NAVIGATION_INDEX.read());
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      body: _body(),
      drawer: widget.showDrawer ? _drawer() : null,
      appBar: _appBar() as PreferredSizeWidget?,
      bottomNavigationBar: _bottomNavigationBar(),
      extendBodyBehindAppBar: false,
      extendBody: false,
      onProfileChange: (_) {
        if (_profileState != LunaProfile.current.toString()) _refreshProfile();
      },
    );
  }

  Widget _drawer() => LunaDrawer(page: LunaModule.SABNZBD.key);

  Widget? _bottomNavigationBar() {
    if (LunaProfile.current.sabnzbdEnabled)
      return SABnzbdNavigationBar(pageController: _pageController);
    return null;
  }

  Widget _appBar() {
    List<String> profiles = LunaBox.profiles.keys.fold([], (value, element) {
      if (LunaBox.profiles.read(element)?.sabnzbdEnabled ?? false)
        value.add(element);
      return value;
    });
    List<Widget>? actions;
    if (LunaProfile.current.sabnzbdEnabled)
      actions = [
        Selector<SABnzbdState, bool>(
          selector: (_, model) => model.error,
          builder: (context, error, widget) =>
              error ? Container() : const SABnzbdAppBarStats(),
        ),
        LunaIconButton(
          icon: Icons.more_vert_rounded,
          onPressed: () async => _handlePopup(),
        ),
      ];
    return LunaAppBar.dropdown(
      title: LunaModule.SABNZBD.title,
      useDrawer: widget.showDrawer,
      hideLeading: !widget.showDrawer,
      profiles: profiles,
      actions: actions,
      pageController: _pageController,
      scrollControllers: SABnzbdNavigationBar.scrollControllers,
    );
  }

  Widget _body() {
    if (!LunaProfile.current.sabnzbdEnabled)
      return LunaMessage.moduleNotEnabled(
        context: context,
        module: LunaModule.SABNZBD.title,
      );
    return LunaPageView(
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
    if (values[0])
      switch (values[1]) {
        case 'web_gui':
          LunaProfile profile = LunaProfile.current;
          await profile.sabnzbdHost.openLink();
          break;
        case 'add_nzb':
          _addNZB();
          break;
        case 'sort':
          _sort();
          break;
        case 'clear_history':
          _clearHistory();
          break;
        case 'complete_action':
          _completeAction();
          break;
        case 'server_details':
          _serverDetails();
          break;
        default:
          LunaLogger().warning('Unknown Case: ${values[1]}');
      }
  }

  Future<void> _serverDetails() async => SABnzbdRoutes.STATISTICS.go();

  Future<void> _completeAction() async {
    List values = await SABnzbdDialogs.changeOnCompleteAction(context);
    if (values[0])
      SABnzbdAPI.from(LunaProfile.current)
          .setOnCompleteAction(values[1])
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
    if (values[0])
      SABnzbdAPI.from(LunaProfile.current)
          .clearHistory(values[1], values[2])
          .then((_) {
        showLunaSuccessSnackBar(
          title: 'History Cleared',
          message: values[3],
        );
        _refreshAllPages();
      }).catchError((error) {
        showLunaErrorSnackBar(
          title: 'Failed to Upload NZB',
          error: error,
        );
      });
  }

  Future<void> _sort() async {
    List values = await SABnzbdDialogs.sortQueue(context);
    if (values[0])
      await SABnzbdAPI.from(LunaProfile.current)
          .sortQueue(values[1], values[2])
          .then((_) {
        showLunaSuccessSnackBar(
          title: 'Sorted Queue',
          message: values[3],
        );
        (_refreshKeys[0] as GlobalKey<RefreshIndicatorState>)
            .currentState
            ?.show();
      }).catchError((error) {
        showLunaErrorSnackBar(
          title: 'Failed to Sort Queue',
          error: error,
        );
      });
  }

  Future<void> _addNZB() async {
    List values = await SABnzbdDialogs.addNZB(context);
    if (values[0])
      switch (values[1]) {
        case 'link':
          _addByURL();
          break;
        case 'file':
          _addByFile();
          break;
        default:
          LunaLogger().warning('Unknown Case: ${values[1]}');
      }
  }

  Future<void> _addByFile() async {
    try {
      LunaFile? _file = await LunaFileSystem().read(context, [
        'nzb',
        'zip',
        'rar',
        'gz',
      ]);
      if (_file != null) {
        if (_file.data.isNotEmpty) {
          await _api.uploadFile(_file.data, _file.name).then((value) {
            _refreshKeys[0]?.currentState?.show();
            showLunaSuccessSnackBar(
              title: 'Uploaded NZB (File)',
              message: _file.name,
            );
          });
        } else {
          showLunaErrorSnackBar(
            title: 'Failed to Upload NZB',
            message: 'Please select a valid file type',
          );
        }
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
    if (values[0])
      await _api
          .uploadURL(values[1])
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
    _api = SABnzbdAPI.from(LunaProfile.current);
    _profileState = LunaProfile.current.toString();
    _refreshAllPages();
  }

  void _refreshAllPages() {
    for (var key in _refreshKeys) key?.currentState?.show();
  }
}
