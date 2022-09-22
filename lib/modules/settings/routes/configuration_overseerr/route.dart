import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';
import 'package:lunasea/router/routes/settings.dart';

class ConfigurationOverseerrRoute extends StatefulWidget {
  const ConfigurationOverseerrRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationOverseerrRoute> createState() => _State();
}

class _State extends State<ConfigurationOverseerrRoute>
    with LunaScrollControllerMixin {
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
      title: LunaModule.OVERSEERR.title,
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
    return LunaBox.profiles.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'Enable ${LunaModule.OVERSEERR.title}',
        trailing: LunaSwitch(
          value: LunaProfile.current.overseerrEnabled,
          onChanged: (value) {
            LunaProfile.current.overseerrEnabled = value;
            LunaProfile.current.save();
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
            args: [LunaModule.OVERSEERR.title],
          ),
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_OVERSEERR_CONNECTION_DETAILS.go,
    );
  }
}
