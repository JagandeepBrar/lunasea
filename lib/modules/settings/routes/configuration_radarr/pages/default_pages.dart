import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class ConfigurationRadarrDefaultPagesRoute extends StatefulWidget {
  const ConfigurationRadarrDefaultPagesRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationRadarrDefaultPagesRoute> createState() => _State();
}

class _State extends State<ConfigurationRadarrDefaultPagesRoute>
    with LunaScrollControllerMixin {
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
      title: 'settings.DefaultPages'.tr(),
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
    const _db = RadarrDatabase.NAVIGATION_INDEX;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'settings.Home'.tr(),
        body: [TextSpan(text: RadarrNavigationBar.titles[_db.read()])],
        trailing: LunaIconButton(icon: RadarrNavigationBar.icons[_db.read()]),
        onTap: () async {
          Tuple2<bool, int> values = await RadarrDialogs().setDefaultPage(
            context,
            titles: RadarrNavigationBar.titles,
            icons: RadarrNavigationBar.icons,
          );
          if (values.item1) _db.update(values.item2);
        },
      ),
    );
  }

  Widget _movieDetailsPage() {
    const _db = RadarrDatabase.NAVIGATION_INDEX_MOVIE_DETAILS;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'radarr.MovieDetails'.tr(),
        body: [
          TextSpan(text: RadarrMovieDetailsNavigationBar.titles[_db.read()]),
        ],
        trailing: LunaIconButton(
          icon: RadarrMovieDetailsNavigationBar.icons[_db.read()],
        ),
        onTap: () async {
          Tuple2<bool, int> values = await RadarrDialogs().setDefaultPage(
            context,
            titles: RadarrMovieDetailsNavigationBar.titles,
            icons: RadarrMovieDetailsNavigationBar.icons,
          );
          if (values.item1) _db.update(values.item2);
        },
      ),
    );
  }

  Widget _addMoviePage() {
    const _db = RadarrDatabase.NAVIGATION_INDEX_ADD_MOVIE;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'radarr.AddMovie'.tr(),
        body: [TextSpan(text: RadarrAddMovieNavigationBar.titles[_db.read()])],
        trailing:
            LunaIconButton(icon: RadarrAddMovieNavigationBar.icons[_db.read()]),
        onTap: () async {
          Tuple2<bool, int> values = await RadarrDialogs().setDefaultPage(
            context,
            titles: RadarrAddMovieNavigationBar.titles,
            icons: RadarrAddMovieNavigationBar.icons,
          );
          if (values.item1) _db.update(values.item2);
        },
      ),
    );
  }

  Widget _systemStatusPage() {
    const _db = RadarrDatabase.NAVIGATION_INDEX_SYSTEM_STATUS;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'radarr.SystemStatus'.tr(),
        body: [
          TextSpan(text: RadarrSystemStatusNavigationBar.titles[_db.read()]),
        ],
        trailing: LunaIconButton(
          icon: RadarrSystemStatusNavigationBar.icons[_db.read()],
        ),
        onTap: () async {
          Tuple2<bool, int> values = await RadarrDialogs().setDefaultPage(
            context,
            titles: RadarrSystemStatusNavigationBar.titles,
            icons: RadarrSystemStatusNavigationBar.icons,
          );
          if (values.item1) _db.update(values.item2);
        },
      ),
    );
  }
}
