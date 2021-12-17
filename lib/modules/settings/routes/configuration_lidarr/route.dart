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
      title: 'Lidarr',
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
        _homePage(),
        //_defaultPagesPage(),
      ],
    );
  }

  Widget _enabledToggle() {
    return ValueListenableBuilder(
      valueListenable: Database.profilesBox.listenable(),
      builder: (context, _, __) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Enable ${LunaModule.LIDARR.name}'),
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
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'settings.ConnectionDetails'.tr()),
      subtitle: LunaText.subtitle(
        text: 'settings.ConnectionDetailsDescription'.tr(
          args: [LunaModule.LIDARR.name],
        ),
      ),
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        SettingsConfigurationLidarrConnectionDetailsRouter()
            .navigateTo(context);
      },
    );
  }

  Widget _homePage() {
    return LidarrDatabaseValue.NAVIGATION_INDEX.listen(
      builder: (context, box, _) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'settings.DefaultPage'.tr()),
        subtitle: LunaText.subtitle(
          text: LidarrNavigationBar
              .titles[LidarrDatabaseValue.NAVIGATION_INDEX.data],
        ),
        trailing: LunaIconButton(
          icon: LidarrNavigationBar
              .icons[LidarrDatabaseValue.NAVIGATION_INDEX.data],
        ),
        onTap: () async {
          List values = await LidarrDialogs.defaultPage(context);
          if (values[0]) LidarrDatabaseValue.NAVIGATION_INDEX.put(values[1]);
        },
      ),
    );
  }
}
