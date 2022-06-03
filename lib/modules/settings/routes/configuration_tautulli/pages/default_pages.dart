import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/tautulli.dart';

class SettingsConfigurationTautulliDefaultPagesRouter
    extends SettingsPageRouter {
  SettingsConfigurationTautulliDefaultPagesRouter()
      : super('/settings/configuration/tautulli/pages');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) =>
      super.noParameterRouteDefinition(router);
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Default Pages',
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        _homePage(),
        _graphsPage(),
        _libraryDetailsPage(),
        _mediaDetailsPage(),
        _userDetailsPage(),
      ],
    );
  }

  Widget _homePage() {
    const _db = TautulliDatabase.NAVIGATION_INDEX;
    return _db.watch(
      builder: (context, _) => LunaBlock(
        title: 'lunasea.Home'.tr(),
        body: [TextSpan(text: TautulliNavigationBar.titles[_db.read()])],
        trailing: LunaIconButton(icon: TautulliNavigationBar.icons[_db.read()]),
        onTap: () async {
          List values = await TautulliDialogs.setDefaultPage(
            context,
            titles: TautulliNavigationBar.titles,
            icons: TautulliNavigationBar.icons,
          );
          if (values[0]) _db.update(values[1]);
        },
      ),
    );
  }

  Widget _graphsPage() {
    const _db = TautulliDatabase.NAVIGATION_INDEX_GRAPHS;
    return _db.watch(
      builder: (context, _) => LunaBlock(
        title: 'Graphs',
        body: [TextSpan(text: TautulliGraphsNavigationBar.titles[_db.read()])],
        trailing:
            LunaIconButton(icon: TautulliGraphsNavigationBar.icons[_db.read()]),
        onTap: () async {
          List values = await TautulliDialogs.setDefaultPage(
            context,
            titles: TautulliGraphsNavigationBar.titles,
            icons: TautulliGraphsNavigationBar.icons,
          );
          if (values[0]) _db.update(values[1]);
        },
      ),
    );
  }

  Widget _libraryDetailsPage() {
    const _db = TautulliDatabase.NAVIGATION_INDEX_LIBRARIES_DETAILS;
    return _db.watch(
      builder: (context, _) => LunaBlock(
        title: 'Library Details',
        body: [
          TextSpan(
              text: TautulliLibrariesDetailsNavigationBar.titles[_db.read()])
        ],
        trailing: LunaIconButton(
            icon: TautulliLibrariesDetailsNavigationBar.icons[_db.read()]),
        onTap: () async {
          List values = await TautulliDialogs.setDefaultPage(
            context,
            titles: TautulliLibrariesDetailsNavigationBar.titles,
            icons: TautulliLibrariesDetailsNavigationBar.icons,
          );
          if (values[0]) _db.update(values[1]);
        },
      ),
    );
  }

  Widget _mediaDetailsPage() {
    const _db = TautulliDatabase.NAVIGATION_INDEX_MEDIA_DETAILS;
    return _db.watch(
      builder: (context, _) => LunaBlock(
        title: 'Media Details',
        body: [
          TextSpan(text: TautulliMediaDetailsNavigationBar.titles[_db.read()]),
        ],
        trailing: LunaIconButton(
            icon: TautulliMediaDetailsNavigationBar.icons[_db.read()]),
        onTap: () async {
          List values = await TautulliDialogs.setDefaultPage(
            context,
            titles: TautulliMediaDetailsNavigationBar.titles,
            icons: TautulliMediaDetailsNavigationBar.icons,
          );
          if (values[0]) _db.update(values[1]);
        },
      ),
    );
  }

  Widget _userDetailsPage() {
    const _db = TautulliDatabase.NAVIGATION_INDEX_USER_DETAILS;
    return _db.watch(
      builder: (context, _) => LunaBlock(
        title: 'User Details',
        body: [
          TextSpan(text: TautulliUserDetailsNavigationBar.titles[_db.read()]),
        ],
        trailing: LunaIconButton(
            icon: TautulliUserDetailsNavigationBar.icons[_db.read()]),
        onTap: () async {
          List values = await TautulliDialogs.setDefaultPage(
            context,
            titles: TautulliUserDetailsNavigationBar.titles,
            icons: TautulliUserDetailsNavigationBar.icons,
          );
          if (values[0]) _db.update(values[1]);
        },
      ),
    );
  }
}
