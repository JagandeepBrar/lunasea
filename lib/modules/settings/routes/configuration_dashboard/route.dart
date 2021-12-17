import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/dashboard.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationDashboardRouter extends SettingsPageRouter {
  SettingsConfigurationDashboardRouter()
      : super('/settings/configuration/dashboard');

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
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'Dashboard',
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        _calendarSettingsPage(),
        _homePage(),
      ],
    );
  }

  Widget _homePage() {
    return DashboardDatabaseValue.NAVIGATION_INDEX.listen(
      builder: (context, box, _) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Default Page'),
        subtitle: LunaText.subtitle(
            text: DashboardNavigationBar
                .titles[DashboardDatabaseValue.NAVIGATION_INDEX.data]),
        trailing: LunaIconButton(
            icon: DashboardNavigationBar
                .icons[DashboardDatabaseValue.NAVIGATION_INDEX.data]),
        onTap: () async {
          Tuple2<bool, int> values =
              await DashboardDialogs().defaultPage(context);
          if (values.item1) {
            DashboardDatabaseValue.NAVIGATION_INDEX.put(values.item2);
          }
        },
      ),
    );
  }

  Widget _calendarSettingsPage() {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Calendar Settings'),
      subtitle: LunaText.subtitle(text: 'Customize the Unified Calendar'),
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        SettingsConfigurationDashboardCalendarSettingsRouter()
            .navigateTo(context);
      },
    );
  }
}
