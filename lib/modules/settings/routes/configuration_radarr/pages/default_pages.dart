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
    return RadarrDatabaseValue.NAVIGATION_INDEX.listen(
      builder: (context, box, _) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Home'),
        subtitle: LunaText.subtitle(
          text: RadarrNavigationBar
              .titles[RadarrDatabaseValue.NAVIGATION_INDEX.data],
        ),
        trailing: LunaIconButton(
          icon: RadarrNavigationBar
              .icons[RadarrDatabaseValue.NAVIGATION_INDEX.data],
        ),
        onTap: () async {
          Tuple2<bool, int> values = await RadarrDialogs().setDefaultPage(
            context,
            titles: RadarrNavigationBar.titles,
            icons: RadarrNavigationBar.icons,
          );
          if (values.item1)
            RadarrDatabaseValue.NAVIGATION_INDEX.put(values.item2);
        },
      ),
    );
  }

  Widget _movieDetailsPage() {
    return RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS.listen(
      builder: (context, box, _) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Movie Details'),
        subtitle: LunaText.subtitle(
            text: RadarrMovieDetailsNavigationBar.titles[
                RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS.data]),
        trailing: LunaIconButton(
            icon: RadarrMovieDetailsNavigationBar.icons[
                RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS.data]),
        onTap: () async {
          Tuple2<bool, int> values = await RadarrDialogs().setDefaultPage(
            context,
            titles: RadarrMovieDetailsNavigationBar.titles,
            icons: RadarrMovieDetailsNavigationBar.icons,
          );
          if (values.item1)
            RadarrDatabaseValue.NAVIGATION_INDEX_MOVIE_DETAILS
                .put(values.item2);
        },
      ),
    );
  }

  Widget _addMoviePage() {
    return RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE.listen(
      builder: (context, box, _) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Add Movie'),
        subtitle: LunaText.subtitle(
            text: RadarrAddMovieNavigationBar
                .titles[RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE.data]),
        trailing: LunaIconButton(
            icon: RadarrAddMovieNavigationBar
                .icons[RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE.data]),
        onTap: () async {
          Tuple2<bool, int> values = await RadarrDialogs().setDefaultPage(
            context,
            titles: RadarrAddMovieNavigationBar.titles,
            icons: RadarrAddMovieNavigationBar.icons,
          );
          if (values.item1)
            RadarrDatabaseValue.NAVIGATION_INDEX_ADD_MOVIE.put(values.item2);
        },
      ),
    );
  }

  Widget _systemStatusPage() {
    return RadarrDatabaseValue.NAVIGATION_INDEX_SYSTEM_STATUS.listen(
      builder: (context, box, _) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'System Status'),
        subtitle: LunaText.subtitle(
            text: RadarrSystemStatusNavigationBar.titles[
                RadarrDatabaseValue.NAVIGATION_INDEX_SYSTEM_STATUS.data]),
        trailing: LunaIconButton(
            icon: RadarrSystemStatusNavigationBar.icons[
                RadarrDatabaseValue.NAVIGATION_INDEX_SYSTEM_STATUS.data]),
        onTap: () async {
          Tuple2<bool, int> values = await RadarrDialogs().setDefaultPage(
            context,
            titles: RadarrSystemStatusNavigationBar.titles,
            icons: RadarrSystemStatusNavigationBar.icons,
          );
          if (values.item1)
            RadarrDatabaseValue.NAVIGATION_INDEX_SYSTEM_STATUS
                .put(values.item2);
        },
      ),
    );
  }
}
