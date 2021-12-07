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
      ],
    );
  }

  Widget _enabledToggle() {
    return ValueListenableBuilder(
      valueListenable: Database.profilesBox.listenable(),
      builder: (context, _, __) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Enable ${LunaModule.SONARR.name}'),
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
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Connection Details'),
      subtitle: LunaText.subtitle(text: 'Connection Details for Sonarr'),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async => SettingsConfigurationSonarrConnectionDetailsRouter()
          .navigateTo(context),
    );
  }

  Widget _defaultPagesPage() {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Default Pages'),
      subtitle: LunaText.subtitle(text: 'Set Default Landing Pages'),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async =>
          SettingsConfigurationSonarrDefaultPagesRouter().navigateTo(context),
    );
  }

  Widget _defaultSortingFilteringPage() {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Default Sorting & Filtering'),
      subtitle:
          LunaText.subtitle(text: 'Set Default Sorting & Filtering Methods'),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async =>
          SettingsConfigurationSonarrDefaultSortingRouter().navigateTo(context),
    );
  }
}
