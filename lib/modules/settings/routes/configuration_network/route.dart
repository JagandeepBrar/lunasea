import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/system/network/network.dart';

class ConfigurationNetworkRoute extends StatefulWidget {
  const ConfigurationNetworkRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationNetworkRoute> createState() => _State();
}

class _State extends State<ConfigurationNetworkRoute>
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
      title: 'settings.Network'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        _useTLSValidation(),
      ],
    );
  }

  Widget _useTLSValidation() {
    const _db = LunaSeaDatabase.NETWORKING_TLS_VALIDATION;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'settings.TLSCertificateValidation'.tr(),
        body: [
          TextSpan(text: 'settings.TLSCertificateValidationDescription'.tr()),
        ],
        trailing: LunaSwitch(
          value: _db.read(),
          onChanged: (data) {
            _db.update(data);
            if (LunaNetwork.isSupported) LunaNetwork().initialize();
          },
        ),
      ),
    );
  }
}
