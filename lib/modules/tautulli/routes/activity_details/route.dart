import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class ActivityDetailsRoute extends StatefulWidget {
  final int sessionKey;

  const ActivityDetailsRoute({
    Key? key,
    required this.sessionKey,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ActivityDetailsRoute>
    with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> _refresh() async {
    context.read<TautulliState>().resetActivity();
    await context.read<TautulliState>().activity;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.sessionKey == -1) {
      return LunaMessage.goBack(
        context: context,
        text: 'tautulli.SessionEnded'.tr(),
      );
    }

    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
      bottomNavigationBar:
          TautulliActivityDetailsBottomActionBar(sessionKey: widget.sessionKey),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
        title: 'tautulli.ActivityDetails'.tr(),
        scrollControllers: [
          scrollController
        ],
        actions: [
          TautulliActivityDetailsUserAction(sessionKey: widget.sessionKey),
          TautulliActivityDetailsMetadataAction(sessionKey: widget.sessionKey),
        ]);
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: _refresh,
      child: FutureBuilder(
        future: context.select<TautulliState, Future<TautulliActivity?>>(
            (state) => state.activity!),
        builder: (context, AsyncSnapshot<TautulliActivity?> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting)
              LunaLogger().error(
                'Unable to pull Tautulli activity session',
                snapshot.error,
                snapshot.stackTrace,
              );
            return LunaMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData) {
            TautulliSession? session = snapshot.data!.sessions!
                .firstWhereOrNull(
                    (element) => element.sessionKey == widget.sessionKey);
            return _session(session);
          }
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _session(TautulliSession? session) {
    if (session == null)
      return LunaMessage.goBack(
        context: context,
        text: 'tautulli.SessionEnded'.tr(),
      );
    return LunaListView(
      controller: scrollController,
      children: [
        TautulliActivityTile(session: session, disableOnTap: true),
        LunaHeader(text: 'tautulli.Metadata'.tr()),
        TautulliActivityDetailsMetadataBlock(session: session),
        LunaHeader(text: 'tautulli.Player'.tr()),
        TautulliActivityDetailsPlayerBlock(session: session),
        LunaHeader(text: 'tautulli.Stream'.tr()),
        TautulliActivityDetailsStreamBlock(session: session),
      ],
    );
  }
}
