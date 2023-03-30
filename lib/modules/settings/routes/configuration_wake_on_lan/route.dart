import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class ConfigurationWakeOnLANRoute extends StatefulWidget {
  const ConfigurationWakeOnLANRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationWakeOnLANRoute> createState() => _State();
}

class _State extends State<ConfigurationWakeOnLANRoute>
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
      scrollControllers: [scrollController],
      title: LunaModule.WAKE_ON_LAN.title,
    );
  }

  Widget _body() {
    return LunaBox.profiles.listenableBuilder(
      builder: (context, _) => LunaListView(
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
      title: 'settings.EnableModule'.tr(args: [LunaModule.WAKE_ON_LAN.title]),
      trailing: LunaSwitch(
        value: LunaProfile.current.wakeOnLANEnabled,
        onChanged: (value) {
          LunaProfile.current.wakeOnLANEnabled = value;
          LunaProfile.current.save();
        },
      ),
    );
  }

  Widget _broadcastAddress() {
    String? broadcastAddress = LunaProfile.current.wakeOnLANBroadcastAddress;
    return LunaBlock(
      title: 'settings.BroadcastAddress'.tr(),
      body: [
        TextSpan(
          text:
              broadcastAddress == '' ? 'lunasea.NotSet'.tr() : broadcastAddress,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values =
            await SettingsDialogs().editBroadcastAddress(
          context,
          broadcastAddress,
        );
        if (_values.item1) {
          LunaProfile.current.wakeOnLANBroadcastAddress = _values.item2;
          LunaProfile.current.save();
        }
      },
    );
  }

  Widget _macAddress() {
    String? macAddress = LunaProfile.current.wakeOnLANMACAddress;
    return LunaBlock(
      title: 'settings.MACAddress'.tr(),
      body: [
        TextSpan(text: macAddress == '' ? 'lunasea.NotSet'.tr() : macAddress),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values = await SettingsDialogs().editMACAddress(
          context,
          macAddress,
        );
        if (_values.item1) {
          LunaProfile.current.wakeOnLANMACAddress = _values.item2;
          LunaProfile.current.save();
        }
      },
    );
  }
}
