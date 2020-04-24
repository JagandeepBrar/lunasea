import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import '../../radarr.dart';

class RadarrDetailsMovieArguments {
    RadarrCatalogueData data;
    final int movieID;

    RadarrDetailsMovieArguments({
        @required this.data,
        @required this.movieID,
    });
}

class RadarrDetailsMovie extends StatefulWidget {
    static const ROUTE_NAME = '/radarr/details/movie';

    @override
    State<RadarrDetailsMovie> createState() => _State();
}

class _State extends State<RadarrDetailsMovie> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    RadarrDetailsMovieArguments _arguments;
    bool _error = false;

    final List<String> _tabTitles = [
        'Overview',
        'Search',
        'Files',  
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
        if(_arguments != null) await RadarrAPI.from(Database.currentProfileObject).getMovie(_arguments.movieID)
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

    Widget get _appBar => LSAppBar(title: 'Movie Details');

    Widget get _body => DefaultTabController(
        length: _tabTitles.length,
        initialIndex: 1,
        child: LSSliverAppBarTabs(
            title: _arguments.data.title,
            backgroundURI: _arguments.data.fanartURI(highRes: true),
            body: TabBarView(
                children: <Widget>[
                    RadarrDetailsOverview(data: _arguments.data),
                    RadarrDetailsSearch(data: _arguments.data),
                    RadarrDetailsFiles(data: _arguments.data),
                ],
            ),
            bottom: TabBar(
                tabs: <Widget>[
                    for(int i =0; i<_tabTitles.length; i++) Tab(
                        child: Text(_tabTitles[i]),
                    ),
                ],
            ),
            actions: <Widget>[
                RadarrDetailsEditButton(
                    data: _arguments.data,
                    remove: (bool withData) => _removeCallback(withData),
                ),
            ],
        ),
    );

    Future<void> _removeCallback(bool withData) async => Navigator.of(context).pop(['remove_movie', withData]);
}
