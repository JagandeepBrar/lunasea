import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesDetailsSeasonsPage extends StatefulWidget {
  final MylarSeries? series;

  const MylarSeriesDetailsSeasonsPage({
    Key? key,
    required this.series,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MylarSeriesDetailsSeasonsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.SONARR,
      body: _body(),
    );
  }

  Widget _body() {
    return LunaRefreshIndicator(
      key: _refreshKey,
      context: context,
      onRefresh: () async => context.read<MylarState>().fetchSeries(
            widget.series!.id!,
          ),
      child: _list(),
    );
  }

  Widget _list() {
    if (widget.series?.seasons?.isEmpty ?? true) {
      return LunaMessage(
        text: 'mylar.NoSeasonsFound'.tr(),
        buttonText: 'lunasea.Refresh'.tr(),
        onTap: _refreshKey.currentState!.show,
      );
    }
    List<MylarSeriesSeason> _seasons = widget.series!.seasons!;
    _seasons.sort((a, b) => a.seasonNumber!.compareTo(b.seasonNumber!));
    return LunaListView(
      controller: MylarSeriesDetailsNavigationBar.scrollControllers[1],
      children: [
        if (_seasons.length > 1)
          MylarSeriesDetailsSeasonAllTile(series: widget.series),
        ...List.generate(
          _seasons.length,
          (index) => MylarSeriesDetailsSeasonTile(
            seriesId: widget.series!.id,
            season: widget.series!.seasons![_seasons.length - 1 - index],
          ),
        ),
      ],
    );
  }
}
