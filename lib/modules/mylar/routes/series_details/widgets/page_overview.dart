import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesDetailsOverviewPage extends StatefulWidget {
  final MylarSeries series;
  final MylarQualityProfile? qualityProfile;
  final MylarLanguageProfile? languageProfile;
  final List<MylarTag> tags;

  const MylarSeriesDetailsOverviewPage({
    Key? key,
    required this.series,
    required this.qualityProfile,
    required this.languageProfile,
    required this.tags,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MylarSeriesDetailsOverviewPage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      module: LunaModule.SONARR,
      body: Selector<MylarState, Future<Map<int?, MylarSeries>>?>(
        selector: (_, state) => state.series,
        builder: (context, movies, _) => LunaListView(
          controller: MylarSeriesDetailsNavigationBar.scrollControllers[0],
          children: [
            MylarSeriesDetailsOverviewDescriptionTile(series: widget.series),
            MylarSeriesDetailsOverviewInformationBlock(
              series: widget.series,
              qualityProfile: widget.qualityProfile,
              languageProfile: widget.languageProfile,
              tags: widget.tags,
            )
          ],
        ),
      ),
    );
  }
}
