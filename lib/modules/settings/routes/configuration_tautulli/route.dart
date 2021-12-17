import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/tautulli.dart';

class SettingsConfigurationTautulliRouter extends SettingsPageRouter {
  SettingsConfigurationTautulliRouter()
      : super('/settings/configuration/tautulli');

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
      title: 'Tautulli',
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        LunaModule.TAUTULLI.informationBanner(),
        _enabledToggle(),
        _connectionDetailsPage(),
        const LunaDivider(),
        _activityRefreshRate(),
        _defaultPagesPage(),
        _defaultTerminationMessage(),
        _statisticsItemCount(),
      ],
    );
  }

  Widget _enabledToggle() {
    return ValueListenableBuilder(
      valueListenable: Database.profilesBox.listenable(),
      builder: (context, _, __) => LunaBlock(
        title: 'Enable ${LunaModule.TAUTULLI.name}',
        trailing: LunaSwitch(
          value: Database.currentProfileObject.tautulliEnabled ?? false,
          onChanged: (value) {
            Database.currentProfileObject.tautulliEnabled = value;
            Database.currentProfileObject.save();
            context.read<TautulliState>().reset();
          },
        ),
      ),
    );
  }

  Widget _connectionDetailsPage() {
    return LunaBlock(
      title: 'Connection Details',
      body: const [
        TextSpan(text: 'Connection Details for Tautulli'),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => SettingsConfigurationTautulliConnectionDetailsRouter()
          .navigateTo(context),
    );
  }

  Widget _defaultPagesPage() {
    return LunaBlock(
      title: 'Default Pages',
      body: const [TextSpan(text: 'Set Default Landing Pages')],
      trailing: const LunaIconButton.arrow(),
      onTap: () async =>
          SettingsConfigurationTautulliDefaultPagesRouter().navigateTo(context),
    );
  }

  Widget _defaultTerminationMessage() {
    TautulliDatabaseValue _db = TautulliDatabaseValue.TERMINATION_MESSAGE;
    return _db.listen(
      builder: (context, box, _) {
        String message = _db.data;
        return LunaBlock(
          title: 'Default Termination Message',
          body: [TextSpan(text: message.isEmpty ? 'Not Set' : message)],
          trailing: const LunaIconButton(icon: Icons.videocam_off_rounded),
          onTap: () async {
            Tuple2<bool, String> result =
                await TautulliDialogs.setTerminationMessage(context);
            if (result.item1) _db.put(result.item2);
          },
        );
      },
    );
  }

  Widget _activityRefreshRate() {
    TautulliDatabaseValue _db = TautulliDatabaseValue.REFRESH_RATE;
    return _db.listen(builder: (context, box, _) {
      String refreshRate;
      if (_db.data == 1) refreshRate = 'Every Second';
      if (_db.data != 1) refreshRate = 'Every ${_db.data} Seconds';
      return LunaBlock(
        title: 'Activity Refresh Rate',
        body: [TextSpan(text: refreshRate)],
        trailing: const LunaIconButton(icon: LunaIcons.REFRESH),
        onTap: () async {
          List<dynamic> _values = await TautulliDialogs.setRefreshRate(context);
          if (_values[0]) TautulliDatabaseValue.REFRESH_RATE.put(_values[1]);
        },
      );
    });
  }

  Widget _statisticsItemCount() {
    TautulliDatabaseValue _db = TautulliDatabaseValue.STATISTICS_STATS_COUNT;
    return _db.listen(
      builder: (context, box, _) {
        String statisticsItems;
        if (_db.data == 1) statisticsItems = '1 Item';
        if (_db.data != 1) statisticsItems = '${_db.data} Items';
        return LunaBlock(
          title: 'Statistics Item Count',
          body: [TextSpan(text: statisticsItems)],
          trailing: const LunaIconButton(icon: Icons.format_list_numbered),
          onTap: () async {
            List<dynamic> _values =
                await TautulliDialogs.setStatisticsItemCount(context);
            if (_values[0]) _db.put(_values[1]);
          },
        );
      },
    );
  }
}
