import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrMoreRoute extends StatefulWidget {
  const ReadarrMoreRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ReadarrMoreRoute> createState() => _State();
}

class _State extends State<ReadarrMoreRoute> with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.READARR,
      hideDrawer: true,
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
      controller: ReadarrNavigationBar.scrollControllers[3],
      children: [
        LunaBlock(
          title: 'readarr.History'.tr(),
          body: [TextSpan(text: 'readarr.HistoryDescription'.tr())],
          trailing: LunaIconButton(
            icon: Icons.history_rounded,
            color: LunaColours().byListIndex(0),
          ),
          onTap: () async => ReadarrHistoryRouter().navigateTo(context),
        ),
        // LunaBlock(
        //   title: 'readarr.ManualImport'.tr(),
        //   body: [TextSpan(text: 'readarr.ManualImportDescription'.tr())],
        //   trailing: LunaIconButton(
        //     icon: Icons.download_done_rounded,
        //     color: LunaColours().byListIndex(1),
        //   ),
        //   onTap: () async => _showComingSoonMessage(),
        // ),
        LunaBlock(
          title: 'readarr.Queue'.tr(),
          body: [TextSpan(text: 'readarr.QueueDescription'.tr())],
          trailing: LunaIconButton(
            icon: Icons.queue_play_next_rounded,
            color: LunaColours().byListIndex(1),
          ),
          onTap: () async => ReadarrQueueRouter().navigateTo(context),
        ),
        // LunaBlock(
        //   title: 'readarr.SystemStatus'.tr(),
        //   body: [TextSpan(text: 'readarr.SystemStatusDescription'.tr())],
        //   trailing: LunaIconButton(
        //     icon: Icons.computer_rounded,
        //     color: LunaColours().byListIndex(3),
        //   ),
        //   onTap: () async => _showComingSoonMessage(),
        // ),
        LunaBlock(
          title: 'readarr.Tags'.tr(),
          body: [TextSpan(text: 'readarr.TagsDescription'.tr())],
          trailing: LunaIconButton(
            icon: Icons.style_rounded,
            color: LunaColours().byListIndex(2),
          ),
          onTap: () async => ReadarrTagsRouter().navigateTo(context),
        ),
      ],
    );
  }
}
