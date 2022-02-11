import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/readarr.dart';

class SettingsConfigurationReadarrRouter extends SettingsPageRouter {
  SettingsConfigurationReadarrRouter() : super('/settings/configuration/readarr');

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
      title: 'Readarr',
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        LunaModule.READARR.informationBanner(),
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
      valueListenable: Database.profiles.box.listenable(),
      builder: (context, dynamic _, __) => LunaBlock(
        title: 'Enable ${LunaModule.READARR.name}',
        trailing: LunaSwitch(
          value: LunaProfile.current.readarrEnabled ?? false,
          onChanged: (value) {
            LunaProfile.current.readarrEnabled = value;
            LunaProfile.current.save();
            context.read<ReadarrState>().reset();
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
            args: [LunaModule.READARR.name],
          ),
        )
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => SettingsConfigurationReadarrConnectionDetailsRouter()
          .navigateTo(context),
    );
  }

  Widget _defaultPagesPage() {
    return LunaBlock(
      title: 'settings.DefaultPages'.tr(),
      body: [TextSpan(text: 'settings.DefaultPagesDescription'.tr())],
      trailing: const LunaIconButton.arrow(),
      onTap: () async =>
          SettingsConfigurationReadarrDefaultPagesRouter().navigateTo(context),
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
          SettingsConfigurationReadarrDefaultOptionsRouter().navigateTo(context),
    );
  }

  Widget _queueSize() {
    ReadarrDatabaseValue _db = ReadarrDatabaseValue.QUEUE_PAGE_SIZE;
    return _db.listen(
      builder: (context, _, __) => LunaBlock(
        title: 'Queue Size',
        body: [TextSpan(text: _db.data == 1 ? '1 Item' : '${_db.data} Items')],
        trailing: const LunaIconButton(icon: Icons.queue_play_next_rounded),
        onTap: () async {
          Tuple2<bool, int> result =
              await ReadarrDialogs().setQueuePageSize(context);
          if (result.item1) _db.put(result.item2);
        },
      ),
    );
  }
}
