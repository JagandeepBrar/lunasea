import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';
import 'package:lunasea/router/routes/mylar.dart';

class MylarMoreRoute extends StatefulWidget {
  const MylarMoreRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<MylarMoreRoute> createState() => _State();
}

class _State extends State<MylarMoreRoute> with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.SONARR,
      body: _body(),
    );
  }

  // ignore: unused_element
  Future<void> _showComingSoonMessage() async {
    showLunaInfoSnackBar(
      title: 'lunasea.ComingSoon'.tr(),
      message: 'This feature is still being developed!',
    );
  }

  Widget _body() {
    return LunaListView(
      controller: MylarNavigationBar.scrollControllers[3],
      children: [
        LunaBlock(
          title: 'mylar.History'.tr(),
          body: [TextSpan(text: 'mylar.HistoryDescription'.tr())],
          trailing: LunaIconButton(
            icon: Icons.history_rounded,
            color: LunaColours().byListIndex(0),
          ),
          onTap: MylarRoutes.HISTORY.go,
        ),
        // LunaBlock(
        //   title: 'mylar.ManualImport'.tr(),
        //   body: [TextSpan(text: 'mylar.ManualImportDescription'.tr())],
        //   trailing: LunaIconButton(
        //     icon: Icons.download_done_rounded,
        //     color: LunaColours().byListIndex(1),
        //   ),
        //   onTap: () async => _showComingSoonMessage(),
        // ),
        LunaBlock(
          title: 'mylar.Queue'.tr(),
          body: [TextSpan(text: 'mylar.QueueDescription'.tr())],
          trailing: LunaIconButton(
            icon: Icons.queue_play_next_rounded,
            color: LunaColours().byListIndex(1),
          ),
          onTap: MylarRoutes.QUEUE.go,
        ),
        // LunaBlock(
        //   title: 'mylar.SystemStatus'.tr(),
        //   body: [TextSpan(text: 'mylar.SystemStatusDescription'.tr())],
        //   trailing: LunaIconButton(
        //     icon: Icons.computer_rounded,
        //     color: LunaColours().byListIndex(3),
        //   ),
        //   onTap: () async => _showComingSoonMessage(),
        // ),
        LunaBlock(
          title: 'mylar.Tags'.tr(),
          body: [TextSpan(text: 'mylar.TagsDescription'.tr())],
          trailing: LunaIconButton(
            icon: Icons.style_rounded,
            color: LunaColours().byListIndex(2),
          ),
          onTap: MylarRoutes.TAGS.go,
        ),
      ],
    );
  }
}
