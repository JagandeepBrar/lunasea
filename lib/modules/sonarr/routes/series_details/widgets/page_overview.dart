import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesDetailsOverviewPage extends StatefulWidget {
  final SonarrSeries series;
  final SonarrQualityProfile? qualityProfile;
  final SonarrLanguageProfile? languageProfile;
  final List<SonarrTag> tags;

  const SonarrSeriesDetailsOverviewPage({
    Key? key,
    required this.series,
    required this.qualityProfile,
    required this.languageProfile,
    required this.tags,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrSeriesDetailsOverviewPage>
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
      body: Selector<SonarrState, Future<Map<int?, SonarrSeries>>?>(
        selector: (_, state) => state.series,
        builder: (context, movies, _) => LunaListView(
          controller: SonarrSeriesDetailsNavigationBar.scrollControllers[0],
          children: [
            SonarrSeriesDetailsOverviewDescriptionTile(series: widget.series),
            SonarrSeriesDetailsOverviewInformationBlock(
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
