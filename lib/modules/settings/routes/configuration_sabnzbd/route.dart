import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sabnzbd.dart';
import 'package:lunasea/router/routes/settings.dart';

class ConfigurationSABnzbdRoute extends StatefulWidget {
  const ConfigurationSABnzbdRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationSABnzbdRoute> createState() => _State();
}

class _State extends State<ConfigurationSABnzbdRoute>
    with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return LunaAppBar(
      title: LunaModule.SABNZBD.title,
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        LunaModule.SABNZBD.informationBanner(),
        _enabledToggle(),
        _connectionDetailsPage(),
        LunaDivider(),
        _defaultPagesPage(),
        //_defaultPagesPage(),
      ],
    );
  }

  Widget _enabledToggle() {
    return LunaBox.profiles.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'settings.EnableModule'.tr(args: [LunaModule.SABNZBD.title]),
        trailing: LunaSwitch(
          value: LunaProfile.current.sabnzbdEnabled,
          onChanged: (value) {
            LunaProfile.current.sabnzbdEnabled = value;
            LunaProfile.current.save();
            context.read<SABnzbdState>().reset();
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
            args: [LunaModule.SABNZBD.title],
          ),
        )
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_SABNZBD_CONNECTION_DETAILS.go,
    );
  }

  Widget _defaultPagesPage() {
    return LunaBlock(
      title: 'settings.DefaultPages'.tr(),
      body: [TextSpan(text: 'settings.DefaultPagesDescription'.tr())],
      trailing: const LunaIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_SABNZBD_DEFAULT_PAGES.go,
    );
  }
}
