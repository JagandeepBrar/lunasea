import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/datetime.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:lunasea/router/routes/tautulli.dart';

class TautulliUserDetailsIPAddresses extends StatefulWidget {
  final TautulliTableUser user;

  const TautulliUserDetailsIPAddresses({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliUserDetailsIPAddresses>
    with AutomaticKeepAliveClientMixin, LunaLoadCallbackMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Future<void> loadCallback() async {
    context.read<TautulliState>().setUserIPs(
          widget.user.userId!,
          context
              .read<TautulliState>()
              .api!
              .users
              .getUserIPs(userId: widget.user.userId!),
        );
    await context.read<TautulliState>().userIPs[widget.user.userId!];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      module: LunaModule.TAUTULLI,
      scaffoldKey: _scaffoldKey,
      body: _body(),
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      context: context,
      key: _refreshKey,
      onRefresh: loadCallback,
      child: FutureBuilder(
        future: context.watch<TautulliState>().userIPs[widget.user.userId!],
        builder: (context, AsyncSnapshot<TautulliUserIPs> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting)
              LunaLogger().error(
                'Unable to fetch Tautulli user IP addresses: ${widget.user.userId}',
                snapshot.error,
                snapshot.stackTrace,
              );
            return LunaMessage.error(onTap: _refreshKey.currentState!.show);
          }
          if (snapshot.hasData) return _list(snapshot.data);
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list(TautulliUserIPs? ips) {
    if ((ips?.ips?.length ?? 0) == 0)
      return LunaMessage(
        text: 'No IPs Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState?.show,
      );
    return LunaListViewBuilder(
      controller: TautulliUserDetailsNavigationBar.scrollControllers[3],
      itemCount: ips!.ips!.length,
      itemBuilder: (context, index) => _tile(ips.ips![index]),
    );
  }

  Widget _tile(TautulliUserIPRecord record) {
    int? _count = record.playCount;
    return LunaBlock(
      title: record.ipAddress,
      body: [
        TextSpan(
          children: [
            TextSpan(text: record.lastSeen?.asAge() ?? 'lunasea.Unknown'.tr()),
            TextSpan(text: LunaUI.TEXT_BULLET.pad()),
            TextSpan(text: _count == 1 ? '1 Play' : '$_count Plays'),
          ],
        ),
        TextSpan(text: record.lastPlayed),
      ],
      backgroundUrl: context.read<TautulliState>().getImageURLFromPath(
            record.thumb ?? '',
            width: MediaQuery.of(context).size.width.truncate(),
          ),
      backgroundHeaders: context.read<TautulliState>().headers,
      onTap: () => TautulliRoutes.IP_DETAILS.go(params: {
        'ip_address': record.ipAddress!,
      }),
    );
  }
}
