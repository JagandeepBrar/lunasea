import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrDetailsSeriesArguments {
    SonarrCatalogueData data;
    final int seriesID;

    SonarrDetailsSeriesArguments({
        @required this.data,
        @required this.seriesID,
    });
}

class SonarrDetailsSeries extends StatefulWidget {
    static const ROUTE_NAME = '/sonarr/details/series';

    @override
    State<SonarrDetailsSeries> createState() => _State();
}

class _State extends State<SonarrDetailsSeries> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final _pageController = PageController(initialPage: 1);
    SonarrDetailsSeriesArguments _arguments;
    bool _error = false;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) {
            _arguments = ModalRoute.of(context).settings.arguments;
            Provider.of<SonarrModel>(context, listen: false).seriesNavigationIndex = 1;
            _fetch();
        });
    }

    Future<void> _fetch() async {
        setState(() => _error = false);
        if(_arguments != null) await SonarrAPI.from(Database.currentProfileObject).getSeries(_arguments.seriesID)
        .then((data) => setState(() {
            _arguments.data = data;
            _error = false;
        }))
        .catchError((_) => setState(() => _error = true));
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        bottomNavigationBar: _arguments != null && _arguments.data != null
            ? _bottomNavigationBar
            : null,
        body: _arguments != null
            ? _arguments.data != null
                ? _body
                : _error 
                    ? LSErrorMessage(onTapHandler: () => _fetch())
                    : LSLoading()
            : null,
    );

    Widget get _appBar => LSAppBar(
        title: _arguments == null || _arguments.data == null
            ? 'Series Details'
            : _arguments.data.title,
        actions: _arguments == null || _arguments.data == null
            ? null
            : <Widget>[
                SonarrDetailsEditButton(
                    data: _arguments.data,
                    remove: (bool withData) => _removeCallback(withData),
                ),
            ],
    );

    Widget get _bottomNavigationBar => SonarrSeriesNavigationBar(pageController: _pageController);

    List<Widget> get _tabs => [
        SonarrDetailsOverview(data: _arguments.data),
        SonarrDetailsSeasonList(data: _arguments.data),
    ];

    Widget get _body => PageView(
        controller: _pageController,
        children: _tabs,
        onPageChanged: _onPageChanged,
    );

    void _onPageChanged(int index) => Provider.of<SonarrModel>(context, listen: false).seriesNavigationIndex = index;

    Future<void> _removeCallback(bool withData) async => Navigator.of(context).pop(['remove_series', withData]);
}