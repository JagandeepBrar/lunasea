import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationRadarrDefaultPagesRouter extends SettingsPageRouter {
  SettingsConfigurationRadarrDefaultPagesRouter()
      : super('/settings/configuration/radarr/pages');

  @override
  Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
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
        _movieDetailsPage(),
        _addMoviePage(),
        _systemStatusPage(),
      ],
    );
  }

  Widget _homePage() {
    RadarrDatabaseValue _db = RadarrDatabaseValue.NAVIGATION_INDEX;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'Home',
        body: [TextSpan(text: RadarrNavigationBar.titles[_db.data])],
        trailing: LunaIconButton(icon: RadarrNavigationBar.icons[_db.data]),
        onTap: () async {
          Tuple2<bool, int> values = await RadarrDialogs().setDefaultPage(
            context,
            titles: RadarrNavigationBar.titles,
            icons: RadarrNavigationBar.icons,
          );
          if (values.item1) _db.put(values.item2);
        },
      ),
    );
  }

  Widget _movieDetailsPage() {
    RadarrDatabaseValue _db =
        RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'Movie Details',
        body: [
          TextSpan(text: RadarrMovieDetailsNavigationBar.titles[_db.data]),
        ],
        trailing: LunaIconButton(
          icon: RadarrMovieDetailsNavigationBar.icons[_db.data],
        ),
        onTap: () async {
          Tuple2<bool, int> values = await RadarrDialogs().setDefaultPage(
            context,
            titles: RadarrMovieDetailsNavigationBar.titles,
            icons: RadarrMovieDetailsNavigationBar.icons,
          );
          if (values.item1) _db.put(values.item2);
        },
      ),
    );
  }

  Widget _addMoviePage() {
    RadarrDatabaseValue _db = RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'Add Movie',
        body: [TextSpan(text: RadarrAddMovieNavigationBar.titles[_db.data])],
        trailing:
            LunaIconButton(icon: RadarrAddMovieNavigationBar.icons[_db.data]),
        onTap: () async {
          Tuple2<bool, int> values = await RadarrDialogs().setDefaultPage(
            context,
            titles: RadarrAddMovieNavigationBar.titles,
            icons: RadarrAddMovieNavigationBar.icons,
          );
          if (values.item1) _db.put(values.item2);
        },
      ),
    );
  }

  Widget _systemStatusPage() {
    RadarrDatabaseValue _db =
        RadarrDatabaseValue.NAVIGATION_INDEX_SYSTEM_STATUS;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'System Status',
        body: [
          TextSpan(text: RadarrSystemStatusNavigationBar.titles[_db.data]),
        ],
        trailing: LunaIconButton(
          icon: RadarrSystemStatusNavigationBar.icons[_db.data],
        ),
        onTap: () async {
          Tuple2<bool, int> values = await RadarrDialogs().setDefaultPage(
            context,
            titles: RadarrSystemStatusNavigationBar.titles,
            icons: RadarrSystemStatusNavigationBar.icons,
          );
          if (values.item1) _db.put(values.item2);
        },
      ),
    );
  }
}
