import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
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
        _defaultPagesPage(),
      ],
    );
  }

  Widget _defaultPagesPage() {
    return LunaBlock(
      title: 'settings.DefaultPages'.tr(),
      body: [TextSpan(text: 'settings.DefaultPagesDescription'.tr())],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => SettingsConfigurationDashboardDefaultPagesRouter()
          .navigateTo(context),
    );
  }

  Widget _calendarSettingsPage() {
    return LunaBlock(
      title: 'Calendar Settings',
      body: const [TextSpan(text: 'Customize the Unified Calendar')],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        SettingsConfigurationDashboardCalendarSettingsRouter()
            .navigateTo(context);
      },
    );
  }
}
