import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/system/network/network.dart';

class SettingsConfigurationNetworkRouter extends SettingsPageRouter {
  SettingsConfigurationNetworkRouter()
      : super('/settings/configuration/network');

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
    LunaDatabaseValue _db = LunaDatabaseValue.NETWORKING_TLS_VALIDATION;
    return _db.listen(
      builder: (context, box, _) => LunaBlock(
        title: 'settings.TLSCertificateValidation'.tr(),
        body: [
          TextSpan(text: 'settings.TLSCertificateValidationDescription'.tr()),
        ],
        trailing: LunaSwitch(
          value: _db.data,
          onChanged: (data) {
            _db.put(data);
            if (LunaNetwork.isSupported) LunaNetwork().initialize();
          },
        ),
      ),
    );
  }
}
