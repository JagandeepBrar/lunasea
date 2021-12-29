import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationLidarrDefaultPagesRouter extends SettingsPageRouter {
  SettingsConfigurationLidarrDefaultPagesRouter()
      : super('/settings/configuration/lidarr/pages');

  @override
  _Widget widget() => _Widget();

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
      ],
    );
  }

  Widget _homePage() {
    LidarrDatabaseValue _db = LidarrDatabaseValue.NAVIGATION_INDEX;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'lunasea.Home'.tr(),
        body: [TextSpan(text: LidarrNavigationBar.titles[_db.data])],
        trailing: LunaIconButton(
          icon: LidarrNavigationBar.icons[_db.data],
        ),
        onTap: () async {
          List values = await LidarrDialogs.defaultPage(context);
          if (values[0]) _db.put(values[1]);
        },
      ),
    );
  }
}
