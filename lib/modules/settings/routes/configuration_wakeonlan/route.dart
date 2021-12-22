import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationWakeOnLANRouter extends SettingsPageRouter {
  SettingsConfigurationWakeOnLANRouter()
      : super('/settings/configuration/wakeonlan');

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
      title: 'Wake on LAN',
    );
  }

  Widget _body() {
    return ValueListenableBuilder(
      valueListenable: Database.profilesBox.listenable(),
      builder: (context, box, _) => LunaListView(
        controller: scrollController,
        children: [
          LunaModule.WAKE_ON_LAN.informationBanner(),
          _enabledToggle(),
          _broadcastAddress(),
          _macAddress(),
        ],
      ),
    );
  }

  Widget _enabledToggle() {
    return LunaBlock(
      title: 'Enable Wake on LAN',
      trailing: LunaSwitch(
        value: Database.currentProfileObject.wakeOnLANEnabled ?? false,
        onChanged: (value) {
          Database.currentProfileObject.wakeOnLANEnabled = value;
          Database.currentProfileObject.save();
        },
      ),
    );
  }

  Widget _broadcastAddress() {
    String broadcastAddress =
        Database.currentProfileObject.wakeOnLANBroadcastAddress;
    return LunaBlock(
      title: 'settings.BroadcastAddress'.tr(),
      body: [
        TextSpan(
          text: broadcastAddress == null || broadcastAddress == ''
              ? 'Not Set'
              : broadcastAddress,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values =
            await SettingsDialogs().editBroadcastAddress(
          context,
          broadcastAddress ?? '',
        );
        if (_values.item1) {
          Database.currentProfileObject.wakeOnLANBroadcastAddress =
              _values.item2;
          Database.currentProfileObject.save();
        }
      },
    );
  }

  Widget _macAddress() {
    String macAddress = Database.currentProfileObject.wakeOnLANMACAddress;
    return LunaBlock(
      title: 'settings.MACAddress'.tr(),
      body: [
        TextSpan(
          text: macAddress == null || macAddress == '' ? 'Not Set' : macAddress,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values = await SettingsDialogs().editMACAddress(
          context,
          macAddress ?? '',
        );
        if (_values.item1) {
          Database.currentProfileObject.wakeOnLANMACAddress = _values.item2;
          Database.currentProfileObject.save();
        }
      },
    );
  }
}
