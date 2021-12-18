import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationLidarrRouter extends SettingsPageRouter {
  SettingsConfigurationLidarrRouter() : super('/settings/configuration/lidarr');

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
      scrollControllers: [scrollController],
      title: LunaModule.LIDARR.name,
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        LunaModule.LIDARR.informationBanner(),
        _enabledToggle(),
        _connectionDetailsPage(),
        const LunaDivider(),
        _defaultPagesPage(),
        //_defaultPagesPage(),
      ],
    );
  }

  Widget _enabledToggle() {
    return ValueListenableBuilder(
      valueListenable: Database.profilesBox.listenable(),
      builder: (context, _, __) => LunaBlock(
        title: 'Enable ${LunaModule.LIDARR.name}',
        trailing: LunaSwitch(
          value: Database.currentProfileObject.lidarrEnabled ?? false,
          onChanged: (value) {
            Database.currentProfileObject.lidarrEnabled = value;
            Database.currentProfileObject.save();
            context.read<LidarrState>().reset();
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
            args: [LunaModule.LIDARR.name],
          ),
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        SettingsConfigurationLidarrConnectionDetailsRouter()
            .navigateTo(context);
      },
    );
  }

  Widget _defaultPagesPage() {
    return LunaBlock(
      title: 'settings.DefaultPages'.tr(),
      body: [TextSpan(text: 'settings.DefaultPagesDescription'.tr())],
      trailing: const LunaIconButton.arrow(),
      onTap: () async =>
          SettingsConfigurationLidarrDefaultPagesRouter().navigateTo(context),
    );
  }
}
