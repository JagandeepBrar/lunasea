import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

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
    final _pageController = PageController(initialPage: 1);
    RadarrDetailsMovieArguments _arguments;
    bool _error = false;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) {
            _arguments = ModalRoute.of(context).settings.arguments;
            Provider.of<RadarrState>(context, listen: false).movieNavigationIndex = 1;
            _fetch();
        });
    }

    Future<void> _fetch() async {
        if(mounted) setState(() => _error = false);
        if(_arguments != null) await RadarrAPI.from(Database.currentProfileObject).getMovie(_arguments.movieID)
        .then((data) {
            if(mounted) setState(() {
                _arguments.data = data;
                _error = false;
            });
        })
        .catchError((_) {
            if(mounted) setState(() => _error = true);
        });
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
                    : LSLoader()
            : null,
    );

    Widget get _appBar => LunaAppBar(
        context: context,
        title: _arguments == null || _arguments.data == null
            ? 'Movie Details'
            : _arguments.data.title,
        actions: _arguments == null || _arguments.data == null
            ? null
            : <Widget>[
                RadarrDetailsEditButton(
                    data: _arguments.data,
                    remove: () => _removeCallback(),
                ),
            ],
    );

    Widget get _bottomNavigationBar => RadarrMovieNavigationBar(pageController: _pageController);

    List<Widget> get _tabs => [
        RadarrDetailsOverview(data: _arguments.data),
        RadarrDetailsSearch(data: _arguments.data),
    ];

    Widget get _body => PageView(
        controller: _pageController,
        children: _tabs,
        onPageChanged: _onPageChanged,
    );

    void _onPageChanged(int index) => Provider.of<RadarrState>(context, listen: false).movieNavigationIndex = index;

    Future<void> _removeCallback() async => Navigator.of(context).pop(['remove_movie']);
}
