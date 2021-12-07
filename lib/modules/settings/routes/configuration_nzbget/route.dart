import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationNZBGetRouter extends SettingsPageRouter {
  SettingsConfigurationNZBGetRouter() : super('/settings/configuration/nzbget');

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
      title: LunaModule.NZBGET.name,
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        LunaModule.NZBGET.informationBanner(),
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
        title: LunaText.title(text: 'Enable ${LunaModule.NZBGET.name}'),
        trailing: LunaSwitch(
          value: Database.currentProfileObject.nzbgetEnabled ?? false,
          onChanged: (value) {
            Database.currentProfileObject.nzbgetEnabled = value;
            Database.currentProfileObject.save();
            context.read<NZBGetState>().reset();
          },
        ),
      ),
    );
  }

  Widget _connectionDetailsPage() {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Connection Details'),
      subtitle: LunaText.subtitle(text: 'Connection Details for NZBGet'),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async {
        SettingsConfigurationNZBGetConnectionDetailsRouter()
            .navigateTo(context);
      },
    );
  }

  Widget _homePage() {
    return NZBGetDatabaseValue.NAVIGATION_INDEX.listen(
      builder: (context, box, _) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Default Page'),
        subtitle: LunaText.subtitle(
          text: NZBGetNavigationBar
              .titles[NZBGetDatabaseValue.NAVIGATION_INDEX.data],
        ),
        trailing: LunaIconButton(
          icon: NZBGetNavigationBar
              .icons[NZBGetDatabaseValue.NAVIGATION_INDEX.data],
        ),
        onTap: () async {
          List values = await NZBGetDialogs.defaultPage(context);
          if (values[0]) NZBGetDatabaseValue.NAVIGATION_INDEX.put(values[1]);
        },
      ),
    );
  }
}
