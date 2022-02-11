import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/readarr.dart';

class SettingsConfigurationReadarrDefaultPagesRouter
    extends SettingsPageRouter {
  SettingsConfigurationReadarrDefaultPagesRouter()
      : super('/settings/configuration/readarr/pages');

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
      title: 'settings.DefaultPages'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        _homePage(),
        _seriesDetailsPage(),
        _seasonDetailsPage(),
      ],
    );
  }

  Widget _homePage() {
    ReadarrDatabaseValue _db = ReadarrDatabaseValue.NAVIGATION_INDEX;
    return _db.listen(
      builder: (context, box, _) {
        return LunaBlock(
          title: 'lunasea.Home'.tr(),
          body: [TextSpan(text: ReadarrNavigationBar.titles[_db.data])],
          trailing: LunaIconButton(icon: ReadarrNavigationBar.icons[_db.data]),
          onTap: () async {
            List values = await ReadarrDialogs.setDefaultPage(
              context,
              titles: ReadarrNavigationBar.titles,
              icons: ReadarrNavigationBar.icons,
            );
            if (values[0]) _db.put(values[1]);
          },
        );
      },
    );
  }

  Widget _seriesDetailsPage() {
    ReadarrDatabaseValue _db =
        ReadarrDatabaseValue.NAVIGATION_INDEX_SERIES_DETAILS;
    return _db.listen(
      builder: (context, box, _) {
        return LunaBlock(
          title: 'readarr.AuthorDetails'.tr(),
          body: [
            TextSpan(text: ReadarrAuthorDetailsNavigationBar.titles[_db.data])
          ],
          trailing: LunaIconButton(
              icon: ReadarrAuthorDetailsNavigationBar.icons[_db.data]),
          onTap: () async {
            List values = await ReadarrDialogs.setDefaultPage(
              context,
              titles: ReadarrAuthorDetailsNavigationBar.titles,
              icons: ReadarrAuthorDetailsNavigationBar.icons,
            );
            if (values[0]) _db.put(values[1]);
          },
        );
      },
    );
  }

  Widget _seasonDetailsPage() {
    ReadarrDatabaseValue _db =
        ReadarrDatabaseValue.NAVIGATION_INDEX_SEASON_DETAILS;
    return _db.listen(
      builder: (context, box, _) {
        return LunaBlock(
          title: 'readarr.BookDetails'.tr(),
          body: [
            TextSpan(text: ReadarrBookDetailsNavigationBar.titles[_db.data])
          ],
          trailing: LunaIconButton(
              icon: ReadarrBookDetailsNavigationBar.icons[_db.data]),
          onTap: () async {
            List values = await ReadarrDialogs.setDefaultPage(
              context,
              titles: ReadarrBookDetailsNavigationBar.titles,
              icons: ReadarrBookDetailsNavigationBar.icons,
            );
            if (values[0]) _db.put(values[1]);
          },
        );
      },
    );
  }
}
