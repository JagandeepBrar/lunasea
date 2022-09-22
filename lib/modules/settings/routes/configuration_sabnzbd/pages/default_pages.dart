import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/database/tables/sabnzbd.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class ConfigurationSABnzbdDefaultPagesRoute extends StatefulWidget {
  const ConfigurationSABnzbdDefaultPagesRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationSABnzbdDefaultPagesRoute> createState() => _State();
}

class _State extends State<ConfigurationSABnzbdDefaultPagesRoute>
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
      title: 'settings.DefaultPages'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        _homePage(),
      ],
    );
  }

  Widget _homePage() {
    const _db = SABnzbdDatabase.NAVIGATION_INDEX;
    return _db.listenableBuilder(
      builder: (context, _) => LunaBlock(
        title: 'lunasea.Home'.tr(),
        body: [TextSpan(text: SABnzbdNavigationBar.titles[_db.read()])],
        trailing: LunaIconButton(icon: SABnzbdNavigationBar.icons[_db.read()]),
        onTap: () async {
          List values = await SABnzbdDialogs.defaultPage(context);
          if (values[0]) _db.update(values[1]);
        },
      ),
    );
  }
}
