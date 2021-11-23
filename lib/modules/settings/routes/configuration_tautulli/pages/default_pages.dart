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
      appBar: _appBar(),
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
    return TautulliDatabaseValue.NAVIGATION_INDEX.listen(
      builder: (context, box, _) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Home'),
        subtitle: LunaText.subtitle(
            text: TautulliNavigationBar
                .titles[TautulliDatabaseValue.NAVIGATION_INDEX.data]),
        trailing: LunaIconButton(
            icon: TautulliNavigationBar
                .icons[TautulliDatabaseValue.NAVIGATION_INDEX.data]),
        onTap: () async {
          List values = await TautulliDialogs.setDefaultPage(context,
              titles: TautulliNavigationBar.titles,
              icons: TautulliNavigationBar.icons);
          if (values[0]) TautulliDatabaseValue.NAVIGATION_INDEX.put(values[1]);
        },
      ),
    );
  }

  Widget _graphsPage() {
    return TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS.listen(
      builder: (context, box, _) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Graphs'),
        subtitle: LunaText.subtitle(
            text: TautulliGraphsNavigationBar
                .titles[TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS.data]),
        trailing: LunaIconButton(
            icon: TautulliGraphsNavigationBar
                .icons[TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS.data]),
        onTap: () async {
          List values = await TautulliDialogs.setDefaultPage(context,
              titles: TautulliGraphsNavigationBar.titles,
              icons: TautulliGraphsNavigationBar.icons);
          if (values[0])
            TautulliDatabaseValue.NAVIGATION_INDEX_GRAPHS.put(values[1]);
        },
      ),
    );
  }

  Widget _libraryDetailsPage() {
    return TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS.listen(
      builder: (context, box, _) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Library Details'),
        subtitle: LunaText.subtitle(
            text: TautulliLibrariesDetailsNavigationBar.titles[
                TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS.data]),
        trailing: LunaIconButton(
            icon: TautulliLibrariesDetailsNavigationBar.icons[
                TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS.data]),
        onTap: () async {
          List values = await TautulliDialogs.setDefaultPage(context,
              titles: TautulliLibrariesDetailsNavigationBar.titles,
              icons: TautulliLibrariesDetailsNavigationBar.icons);
          if (values[0])
            TautulliDatabaseValue.NAVIGATION_INDEX_LIBRARIES_DETAILS
                .put(values[1]);
        },
      ),
    );
  }

  Widget _mediaDetailsPage() {
    return TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS.listen(
      builder: (context, box, _) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Media Details'),
        subtitle: LunaText.subtitle(
            text: TautulliMediaDetailsNavigationBar.titles[
                TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS.data]),
        trailing: LunaIconButton(
            icon: TautulliMediaDetailsNavigationBar.icons[
                TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS.data]),
        onTap: () async {
          List values = await TautulliDialogs.setDefaultPage(context,
              titles: TautulliMediaDetailsNavigationBar.titles,
              icons: TautulliMediaDetailsNavigationBar.icons);
          if (values[0])
            TautulliDatabaseValue.NAVIGATION_INDEX_MEDIA_DETAILS.put(values[1]);
        },
      ),
    );
  }

  Widget _userDetailsPage() {
    return TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS.listen(
      builder: (context, box, _) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'User Details'),
        subtitle: LunaText.subtitle(
            text: TautulliUserDetailsNavigationBar.titles[
                TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS.data]),
        trailing: LunaIconButton(
            icon: TautulliUserDetailsNavigationBar.icons[
                TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS.data]),
        onTap: () async {
          List values = await TautulliDialogs.setDefaultPage(context,
              titles: TautulliUserDetailsNavigationBar.titles,
              icons: TautulliUserDetailsNavigationBar.icons);
          if (values[0])
            TautulliDatabaseValue.NAVIGATION_INDEX_USER_DETAILS.put(values[1]);
        },
      ),
    );
  }
}
