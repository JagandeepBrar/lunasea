import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/router/routes/settings.dart';

class ConfigurationDashboardRoute extends StatefulWidget {
  const ConfigurationDashboardRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationDashboardRoute> createState() => _State();
}

class _State extends State<ConfigurationDashboardRoute>
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
      onTap: SettingsRoutes.CONFIGURATION_DASHBOARD_DEFAULT_PAGES.go,
    );
  }

  Widget _calendarSettingsPage() {
    return LunaBlock(
      title: 'settings.CalendarSettings'.tr(),
      body: [TextSpan(text: 'settings.CalendarSettingsDescription'.tr())],
      trailing: const LunaIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_DASHBOARD_CALENDAR.go,
    );
  }
}
