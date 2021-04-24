import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsConfigurationNZBGetDefaultPagesRouter extends SettingsPageRouter {
  SettingsConfigurationNZBGetDefaultPagesRouter()
      : super('/settings/configuration/nzbget/pages');

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
      title: 'Default Pages',
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
    return NZBGetDatabaseValue.NAVIGATION_INDEX.listen(
      builder: (context, box, _) => LunaListTile(
        context: context,
        title: LunaText.title(text: 'Home'),
        subtitle: LunaText.subtitle(
          text: NZBGetNavigationBar
              .titles[NZBGetDatabaseValue.NAVIGATION_INDEX.data],
        ),
        trailing: LunaIconButton(
          icon: NZBGetNavigationBar
              .icons[NZBGetDatabaseValue.NAVIGATION_INDEX.data],
        ),
        onTap: () async {
          List values = await NZBGetDialogs.defaultPage(context);
          if (values[0]) NZBGetDatabaseValue.NAVIGATION_INDEX.put(values[1]);
        },
      ),
    );
  }
}
