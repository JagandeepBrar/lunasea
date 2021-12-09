import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliUserDetailsIPAddresses extends StatefulWidget {
  final TautulliTableUser user;

  const TautulliUserDetailsIPAddresses({
    Key key,
    @required this.user,
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
          widget.user.userId,
          context
              .read<TautulliState>()
              .api
              .users
              .getUserIPs(userId: widget.user.userId),
        );
    await context.read<TautulliState>().userIPs[widget.user.userId];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
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
        future: context.watch<TautulliState>().userIPs[widget.user.userId],
        builder: (context, AsyncSnapshot<TautulliUserIPs> snapshot) {
          if (snapshot.hasError) {
            if (snapshot.connectionState != ConnectionState.waiting)
              LunaLogger().error(
                'Unable to fetch Tautulli user IP addresses: ${widget.user.userId}',
                snapshot.error,
                snapshot.stackTrace,
              );
            return LunaMessage.error(onTap: _refreshKey.currentState?.show);
          }
          if (snapshot.hasData) return _list(snapshot.data);
          return const LunaLoader();
        },
      ),
    );
  }

  Widget _list(TautulliUserIPs ips) {
    if ((ips?.ips?.length ?? 0) == 0)
      return LunaMessage(
        text: 'No IPs Found',
        buttonText: 'Refresh',
        onTap: _refreshKey.currentState?.show,
      );
    return LunaListViewBuilder(
      controller: TautulliUserDetailsNavigationBar.scrollControllers[3],
      itemCount: ips.ips.length,
      itemBuilder: (context, index) => _tile(ips.ips[index]),
    );
  }

  Widget _tile(TautulliUserIPRecord record) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: record.ipAddress),
      subtitle: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.white70,
            fontSize: LunaUI.FONT_SIZE_H3,
          ),
          children: [
            TextSpan(text: record.lastSeen?.lunaAge ?? 'Unknown'),
            const TextSpan(text: '\t${LunaUI.TEXT_EMDASH}\t'),
            TextSpan(
              text: record.playCount == 1
                  ? '1 Play'
                  : '${record.playCount} Plays',
            ),
            const TextSpan(text: '\n'),
            TextSpan(text: record.lastPlayed),
          ],
        ),
        maxLines: 2,
        softWrap: false,
        overflow: TextOverflow.fade,
      ),
      decoration: record.thumb != null && record.thumb.isNotEmpty
          ? LunaCardDecoration(
              uri: context.read<TautulliState>().getImageURLFromPath(
                    record.thumb ?? '',
                    width: MediaQuery.of(context).size.width.truncate(),
                  ),
              headers: context.read<TautulliState>().headers,
            )
          : null,
      contentPadding: true,
      onTap: () async => TautulliIPAddressDetailsRouter()
          .navigateTo(context, ipAddress: record.ipAddress),
    );
  }
}
