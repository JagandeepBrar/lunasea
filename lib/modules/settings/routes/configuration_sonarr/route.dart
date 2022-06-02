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
      appBar: _appBar() as PreferredSizeWidget?,
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
        LunaDivider(),
        _defaultOptionsPage(),
        _defaultPagesPage(),
        _queueSize(),
      ],
    );
  }

  Widget _enabledToggle() {
    return ValueListenableBuilder(
      valueListenable: LunaBox.profiles.listenable(),
      builder: (context, dynamic _, __) => LunaBlock(
        title: 'Enable ${LunaModule.SONARR.title}',
        trailing: LunaSwitch(
          value: LunaProfile.current.sonarrEnabled ?? false,
          onChanged: (value) {
            LunaProfile.current.sonarrEnabled = value;
            LunaProfile.current.save();
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
            args: [LunaModule.SONARR.title],
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

  Widget _defaultOptionsPage() {
    return LunaBlock(
      title: 'settings.DefaultOptions'.tr(),
      body: [
        TextSpan(text: 'settings.DefaultOptionsDescription'.tr()),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async =>
          SettingsConfigurationSonarrDefaultOptionsRouter().navigateTo(context),
    );
  }

  Widget _queueSize() {
    const _db = SonarrDatabase.QUEUE_PAGE_SIZE;
    return _db.listen(
      builder: (context, _) => LunaBlock(
        title: 'Queue Size',
        body: [
          TextSpan(text: _db.read() == 1 ? '1 Item' : '${_db.read()} Items')
        ],
        trailing: const LunaIconButton(icon: Icons.queue_play_next_rounded),
        onTap: () async {
          Tuple2<bool, int> result =
              await SonarrDialogs().setQueuePageSize(context);
          if (result.item1) _db.update(result.item2);
        },
      ),
    );
  }
}
