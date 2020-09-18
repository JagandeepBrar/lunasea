import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tautulli/tautulli.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliUserDetailsIPAddresses extends StatefulWidget {
    final TautulliTableUser user;

    TautulliUserDetailsIPAddresses({
        Key key,
        @required this.user,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliUserDetailsIPAddresses> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    
    @override
    bool get wantKeepAlive => true;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.scheduleFrameCallback((_) => _refresh());
    }

    Future<void> _refresh() async {
        TautulliState _global = Provider.of<TautulliState>(context, listen: false);
        TautulliLocalState _local = Provider.of<TautulliLocalState>(context, listen: false);
        _local.setUserIPs(
            widget.user.userId,
            _global.api.users.getUserIPs(userId: widget.user.userId),
        );
        await _local.userIPs[widget.user.userId];
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: _body,
        );
    }

    Widget get _body => LSRefreshIndicator(
        refreshKey: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
            future: Provider.of<TautulliLocalState>(context).userIPs[widget.user.userId],
            builder: (context, AsyncSnapshot<TautulliUserIPs> snapshot) {
                if(snapshot.hasError) {
                    if(snapshot.connectionState != ConnectionState.waiting) {
                        Logger.error(
                            'TautulliUserDetailsIPAddresses',
                            '_body',
                            'Unable to fetch Tautulli user IP addresses: ${widget.user.userId}',
                            snapshot.error,
                            null,
                            uploadToSentry: !(snapshot.error is DioError),
                        );
                    }
                    return LSErrorMessage(onTapHandler: () async => _refreshKey.currentState.show());
                }
                if(snapshot.hasData) return snapshot.data.ips.length == 0
                    ? _noIPs()
                    : _ips(snapshot.data);
                return LSLoader();
            },
        ),
    );

    Widget _ips(TautulliUserIPs ips) => LSListViewBuilder(
        itemCount: ips.ips.length,
        itemBuilder: (context, index) => _tile(ips.ips[index]),
    );

    Widget _noIPs() => LSGenericMessage(
        text: 'No IPs Found',
        showButton: true,
        buttonText: 'Refresh',
        onTapHandler: () async => _refreshKey.currentState.show(),
    );

    Widget _tile(TautulliUserIPRecord record) => LSCardTile(
        title: LSTitle(text: record.ipAddress),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                children: [
                    TextSpan(text: DateTime.now().lsDateTime_ageString(record.lastSeen)),
                    TextSpan(text: '\t${Constants.TEXT_EMDASH}\t'),
                    TextSpan(text: record.playCount == 1
                        ? '1 Play'
                        : '${record.playCount} Plays',
                    ),
                    TextSpan(text: '\n'),
                    TextSpan(text: record.lastPlayed),
                ],
            ),
            maxLines: 2,
            softWrap: false,
            overflow: TextOverflow.fade,
        ),
        decoration: record.thumb != null && record.thumb.isNotEmpty
            ? LSCardBackground(
                uri: Provider.of<TautulliState>(context, listen: false).getImageURLFromPath(
                    record.thumb ?? '',
                    width: MediaQuery.of(context).size.width.truncate(),
                ),
                headers: Provider.of<TautulliState>(context, listen: false).headers,
                darken: true,
            )
            : null,
        padContent: true,
        onTap: () async => TautulliIPAddressDetailsRouter.navigateTo(context, ip: record.ipAddress),
    );
}
