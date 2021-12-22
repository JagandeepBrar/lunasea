import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationOverseerrRouter extends SettingsPageRouter {
  SettingsConfigurationOverseerrRouter()
      : super('/settings/configuration/overseerr');

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
      title: LunaModule.OVERSEERR.name,
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        LunaModule.OVERSEERR.informationBanner(),
        _enabledToggle(),
        _connectionDetailsPage(),
      ],
    );
  }

  Widget _enabledToggle() {
    return ValueListenableBuilder(
      valueListenable: Database.profilesBox.listenable(),
      builder: (context, _, __) => LunaBlock(
        title: 'Enable ${LunaModule.OVERSEERR.name}',
        trailing: LunaSwitch(
          value: Database.currentProfileObject.overseerrEnabled ?? false,
          onChanged: (value) {
            Database.currentProfileObject.overseerrEnabled = value;
            Database.currentProfileObject.save();
            context.read<OverseerrState>().reset();
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
            args: [LunaModule.OVERSEERR.name],
          ),
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => SettingsConfigurationOverseerrConnectionDetailsRouter()
          .navigateTo(context),
    );
  }
}
