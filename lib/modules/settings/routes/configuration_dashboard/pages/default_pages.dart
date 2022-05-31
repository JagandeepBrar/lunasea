import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/tables/dashboard.dart';
import 'package:lunasea/modules/settings.dart';

import 'package:lunasea/modules/dashboard/core/dialogs.dart';
import 'package:lunasea/modules/dashboard/routes/dashboard/widgets/navigation_bar.dart';

class SettingsConfigurationDashboardDefaultPagesRouter
    extends SettingsPageRouter {
  SettingsConfigurationDashboardDefaultPagesRouter()
      : super('/settings/configuration/dashboard/pages');

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
    const _db = DashboardDatabase.NAVIGATION_INDEX;
    return _db.listen(
      builder: (context, _) => LunaBlock(
        title: 'lunasea.Home'.tr(),
        body: [TextSpan(text: HomeNavigationBar.titles[_db.read()])],
        trailing: LunaIconButton(icon: HomeNavigationBar.icons[_db.read()]),
        onTap: () async {
          final values = await DashboardDialogs().defaultPage(context);
          if (values.item1) _db.update(values.item2);
        },
      ),
    );
  }
}
