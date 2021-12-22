import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/sonarr.dart';

class SettingsConfigurationSonarrRouter extends SettingsPageRouter {
  SettingsConfigurationSonarrRouter() : super('/settings/configuration/sonarr');

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
      title: 'Sonarr',
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        LunaModule.SONARR.informationBanner(),
        _enabledToggle(),
        _connectionDetailsPage(),
        const LunaDivider(),
        _defaultPagesPage(),
        _defaultSortingFilteringPage(),
        _queueSize(),
      ],
    );
  }

  Widget _enabledToggle() {
    return ValueListenableBuilder(
      valueListenable: Database.profilesBox.listenable(),
      builder: (context, _, __) => LunaBlock(
        title: 'Enable ${LunaModule.SONARR.name}',
        trailing: LunaSwitch(
          value: Database.currentProfileObject.sonarrEnabled ?? false,
          onChanged: (value) {
            Database.currentProfileObject.sonarrEnabled = value;
            Database.currentProfileObject.save();
            context.read<SonarrState>().reset();
          },
        ),
      ),
    );
  }

  Widget _connectionDetailsPage() {
    return LunaBlock(
      title: 'settings.ConnectionDetails'.tr(),
      body: [
        TextSpan(
          text: 'settings.ConnectionDetailsDescription'.tr(
            args: [LunaModule.SONARR.name],
          ),
        )
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => SettingsConfigurationSonarrConnectionDetailsRouter()
          .navigateTo(context),
    );
  }

  Widget _defaultPagesPage() {
    return LunaBlock(
      title: 'settings.DefaultPages'.tr(),
      body: [TextSpan(text: 'settings.DefaultPagesDescription'.tr())],
      trailing: const LunaIconButton.arrow(),
      onTap: () async =>
          SettingsConfigurationSonarrDefaultPagesRouter().navigateTo(context),
    );
  }

  Widget _defaultSortingFilteringPage() {
    return LunaBlock(
      title: 'settings.DefaultSortingAndFiltering'.tr(),
      body: [
        TextSpan(text: 'settings.DefaultSortingAndFilteringDescription'.tr()),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async =>
          SettingsConfigurationSonarrDefaultSortingRouter().navigateTo(context),
    );
  }

  Widget _queueSize() {
    SonarrDatabaseValue _db = SonarrDatabaseValue.QUEUE_PAGE_SIZE;
    return _db.listen(
      builder: (context, _, __) => LunaBlock(
        title: 'Queue Size',
        body: [TextSpan(text: _db.data == 1 ? '1 Item' : '${_db.data} Items')],
        trailing: const LunaIconButton(icon: Icons.queue_rounded),
        onTap: () async {
          Tuple2<bool, int> result =
              await SonarrDialogs().setQueuePageSize(context);
          if (result.item1) _db.put(result.item2);
        },
      ),
    );
  }
}
