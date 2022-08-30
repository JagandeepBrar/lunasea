import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/int/bytes.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class StatisticsRoute extends StatefulWidget {
  const StatisticsRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<StatisticsRoute> createState() => _State();
}

class _State extends State<StatisticsRoute> with LunaScrollControllerMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<SABnzbdStatisticsData>? _future;
  SABnzbdStatisticsData? _data;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  Widget build(BuildContext context) => LunaScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: _appBar as PreferredSizeWidget?,
        body: _body,
      );

  Future<SABnzbdStatisticsData> _fetch() async =>
      SABnzbdAPI.from(LunaProfile.current).getStatistics();

  Future<void> _refresh() async {
    if (mounted)
      setState(() {
        _future = _fetch();
      });
  }

  Widget get _appBar => LunaAppBar(
        title: 'Server Statistics',
        scrollControllers: [scrollController],
      );

  Widget get _body => LunaRefreshIndicator(
        context: context,
        key: _refreshKey,
        onRefresh: _refresh,
        child: FutureBuilder(
          future: _future,
          builder: (context, AsyncSnapshot<SABnzbdStatisticsData> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                {
                  if (snapshot.hasError || snapshot.data == null)
                    return LunaMessage.error(onTap: _refresh);
                  _data = snapshot.data;
                  return _list;
                }
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
              default:
                return const LunaLoader();
            }
          },
        ),
      );

  Widget get _list => LunaListView(
        controller: scrollController,
        children: <Widget>[
          const LunaHeader(text: 'Status'),
          _status(),
          const LunaHeader(text: 'Statistics'),
          _statistics(),
          ..._serverStatistics(),
        ],
      );

  Widget _status() {
    return LunaTableCard(
      content: [
        LunaTableContent(title: 'Uptime', body: _data!.uptime),
        LunaTableContent(title: 'Version', body: _data!.version),
        LunaTableContent(
            title: 'Temp. Space',
            body: '${_data!.tempFreespace.toString()} GB'),
        LunaTableContent(
            title: 'Final Space',
            body: '${_data!.finalFreespace.toString()} GB'),
      ],
    );
  }

  Widget _statistics() {
    return LunaTableCard(
      content: [
        LunaTableContent(title: 'Daily', body: _data!.dailyUsage.asBytes()),
        LunaTableContent(title: 'Weekly', body: _data!.weeklyUsage.asBytes()),
        LunaTableContent(title: 'Monthly', body: _data!.monthlyUsage.asBytes()),
        LunaTableContent(title: 'Total', body: _data!.totalUsage.asBytes()),
      ],
    );
  }

  List<Widget> _serverStatistics() {
    return _data!.servers
        .map((server) => [
              LunaHeader(text: server.name),
              LunaTableCard(
                content: [
                  LunaTableContent(
                      title: 'Daily', body: server.dailyUsage.asBytes()),
                  LunaTableContent(
                      title: 'Weekly', body: server.weeklyUsage.asBytes()),
                  LunaTableContent(
                      title: 'Monthly', body: server.monthlyUsage.asBytes()),
                  LunaTableContent(
                      title: 'Total', body: server.totalUsage.asBytes()),
                ],
              ),
            ])
        .expand((element) => element)
        .toList();
  }
}
