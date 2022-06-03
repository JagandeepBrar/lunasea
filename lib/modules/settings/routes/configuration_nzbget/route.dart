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
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: LunaModule.NZBGET.title,
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
        LunaDivider(),
        _defaultPagesPage(),
        //_defaultPagesPage(),
      ],
    );
  }

  Widget _enabledToggle() {
    return LunaBox.profiles.watch(
      builder: (context, _) => LunaBlock(
        title: 'settings.EnableModule'.tr(args: [LunaModule.NZBGET.title]),
        trailing: LunaSwitch(
          value: LunaProfile.current.nzbgetEnabled ?? false,
          onChanged: (value) {
            LunaProfile.current.nzbgetEnabled = value;
            LunaProfile.current.save();
            context.read<NZBGetState>().reset();
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
          text: 'settings.ConnectionDetailsDescription'
              .tr(args: [LunaModule.NZBGET.title]),
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        SettingsConfigurationNZBGetConnectionDetailsRouter()
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
          SettingsConfigurationNZBGetDefaultPagesRouter().navigateTo(context),
    );
  }
}
