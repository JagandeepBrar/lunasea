import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/modules/tautulli.dart';

class SettingsSystemDebugMenuUIRouter extends SettingsPageRouter {
  SettingsSystemDebugMenuUIRouter() : super('/settings/debug_menu/ui');

  @override
  _Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget>
    with LunaScrollControllerMixin, TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _iconController;
  late AnimationController _hideController;
  bool _isFabVisible = true;
  bool _isFabPaused = false;

  @override
  void initState() {
    super.initState();
    _setupIconController();
    _setupHideController();
  }

  @override
  void dispose() {
    _iconController.dispose();
    _hideController.dispose();
    scrollController.removeListener(scrollControllerListener);
    super.dispose();
  }

  void scrollControllerListener() {
    if (!scrollController.hasClients) return;
    switch (scrollController.position.userScrollDirection) {
      case ScrollDirection.forward:
        if (!_isFabVisible) {
          _hideController.forward();
          _isFabVisible = true;
        }
        break;
      case ScrollDirection.reverse:
        if (_isFabVisible) {
          _hideController.reverse();
          _isFabVisible = false;
        }
        break;
      case ScrollDirection.idle:
        break;
    }
  }

  void _setupIconController() {
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: LunaUI.ANIMATION_SPEED),
    );
  }

  void _setupHideController() {
    _hideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: LunaUI.ANIMATION_SPEED),
    );
    _hideController.forward();
    scrollController.addListener(scrollControllerListener);
  }

  Future<void> _toggle(BuildContext context) async {
    HapticFeedback.lightImpact();
    _isFabPaused ? _iconController.reverse() : _iconController.forward();
    setState(() => _isFabPaused = !_isFabPaused);
  }

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      title: 'settings.DebugMenu'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _floatingActionButton() {
    return ScaleTransition(
      scale: _hideController,
      child: InkWell(
        child: LunaFloatingActionButtonAnimated(
          controller: _iconController,
          icon: AnimatedIcons.pause_play,
          onPressed: () => _toggle(context),
        ),
        borderRadius: BorderRadius.circular(28.0),
      ),
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        ..._lunaBlock(),
        ..._tableContents(),
        ..._graphs(),
      ],
    );
  }

  List<TextSpan> _generateBody(int l) =>
      List.generate(l, (i) => TextSpan(text: 'Body ${i + 1}'));

  List<LunaTableContent> _generateTableContent(int l) => List.generate(l,
      (i) => LunaTableContent(title: 'Title ${i + 1}', body: 'Body ${i + 1}'));

  List<Widget> _tableContents() {
    return [
      LunaExpandableListTile(
        title: 'Expandable 1',
        collapsedSubtitles: _generateBody(2),
        expandedTableContent: _generateTableContent(4),
        collapsedTrailing: const LunaIconButton(icon: LunaIcons.ARROW_RIGHT),
      ),
      LunaTableCard(content: _generateTableContent(4)),
    ];
  }

  List<Widget> _lunaBlock() {
    return [
      LunaBlock(
        title: 'Title 1',
        body: _generateBody(1),
        bodyLeadingIcons: const [LunaIcons.DOWNLOAD],
        leading: const LunaIconButton(icon: LunaIcons.ARROW_RIGHT),
        trailing: const LunaIconButton(icon: LunaIcons.ARROW_RIGHT),
      ),
      LunaBlock(
        disabled: true,
        title: 'Title 1',
        body: _generateBody(1),
        bodyLeadingIcons: const [LunaIcons.DOWNLOAD],
        leading: const LunaIconButton(icon: LunaIcons.ARROW_RIGHT),
        trailing: const LunaIconButton(icon: LunaIcons.ARROW_RIGHT),
      ),
      const LunaBlock(
        skeletonEnabled: true,
        skeletonPoster: true,
        skeletonSubtitles: 2,
      ),
      LunaBlock(
        title: 'Title 1',
        body: _generateBody(2),
        posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
        posterUrl: TheMovieDB.getPosterURL('/qLX91FhHWCVrxDVsw0g2UD5c3Zk.jpg'),
        backgroundUrl:
            TheMovieDB.getPosterURL('/wR3ZbCWM55qbJBcIO7rHm0MB68j.jpg'),
        onTap: () {},
      ),
    ];
  }

  List<Widget> _graphs() {
    TautulliGraphData data = TautulliGraphData.fromJson(json.decode(
      '{"categories":["2022-02-05","2022-02-06","2022-02-07","2022-02-08","2022-02-09","2022-02-10","2022-02-11","2022-02-12","2022-02-13","2022-02-14","2022-02-15","2022-02-16","2022-02-17","2022-02-18"],"series":[{"name":"Direct Play","data":[65,27,38,33,31,48,60,33,32,33,20,22,28,68]},{"name":"Direct Stream","data":[0,0,0,0,0,2,0,4,0,0,2,1,0,2]},{"name":"Transcode","data":[9,12,23,12,20,20,9,7,8,5,21,19,23,33]}]}',
    ));
    return [
      LunaCard(
        context: context,
        child: Column(
          children: [
            SizedBox(
              height: TautulliGraphHelper.GRAPH_HEIGHT,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                child: LineChart(
                  LineChartData(
                    gridData: TautulliGraphHelper().gridData(),
                    titlesData: TautulliLineGraphHelper.titlesData(data),
                    borderData: TautulliGraphHelper().borderData(),
                    lineBarsData: TautulliLineGraphHelper.lineBarsData(data),
                    lineTouchData:
                        TautulliLineGraphHelper.lineTouchData(context, data),
                  ),
                ),
                padding: LunaUI.MARGIN_DEFAULT,
              ),
            ),
            TautulliGraphHelper().createLegend(data.series!),
          ],
        ),
      ),
      LunaCard(
        context: context,
        child: Column(
          children: [
            SizedBox(
              height: TautulliGraphHelper.GRAPH_HEIGHT,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                child: BarChart(
                  BarChartData(
                    alignment: TautulliGraphHelper().chartAlignment(),
                    gridData: TautulliGraphHelper().gridData(),
                    titlesData: TautulliGraphHelper().titlesData(data),
                    borderData: TautulliGraphHelper().borderData(),
                    barGroups: TautulliBarGraphHelper.barGroups(context, data),
                    barTouchData:
                        TautulliBarGraphHelper.barTouchData(context, data),
                  ),
                ),
                padding: LunaUI.MARGIN_DEFAULT,
              ),
            ),
            TautulliGraphHelper().createLegend(data.series!),
          ],
        ),
      ),
    ];
  }
}
