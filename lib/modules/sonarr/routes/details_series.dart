import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import '../../sonarr.dart';

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
    SonarrDetailsSeriesArguments _arguments;
    bool _error = false;
    final List<String> _tabTitles = [
        'Overview',
        'Seasons',  
    ];

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) {
            _arguments = ModalRoute.of(context).settings.arguments;
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
        appBar: _arguments == null || _arguments.data == null ? _appBar : null,
        body: _arguments != null
            ? _arguments.data != null
                ? _body
                : _error 
                    ? LSErrorMessage(onTapHandler: () => _fetch())
                    : LSLoading()
            : null,
    );

    Widget get _appBar => LSAppBar(title: 'Series Details');

    Widget get _body => DefaultTabController(
        length: _tabTitles.length,
        initialIndex: 1,
        child: LSSliverAppBarTabs(
            title: _arguments.data.title,
            backgroundURI: _arguments.data.fanartURI(highRes: true),
            bottom: TabBar(
                tabs: <Widget>[
                    for(int i =0; i<_tabTitles.length; i++) Tab(
                        child: Text(_tabTitles[i]),
                    ),
                ],
            ),
            body: TabBarView(
                children: <Widget>[
                    SonarrDetailsOverview(data: _arguments.data),
                    SonarrDetailsSeasonList(data: _arguments.data)
                ],
            ),
            actions: <Widget>[
                SonarrDetailsEditButton(
                    data: _arguments.data,
                    remove: (bool withData) => _removeCallback(withData),
                ),
            ],
        ),
    );

    Future<void> _removeCallback(bool withData) async => Navigator.of(context).pop(['remove_series', withData]);
}