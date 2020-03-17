import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/widgets/pages/lidarr.dart';

class LidarrDetailsArtistArguments {
    LidarrCatalogueData data;
    final int artistID;

    LidarrDetailsArtistArguments({
        @required this.data,
        @required this.artistID,
    });
}

class LidarrDetailsArtist extends StatefulWidget {
    static const ROUTE_NAME = '/lidarr/details/artist';

    @override
    State<LidarrDetailsArtist> createState() => _State();
}

class _State extends State<LidarrDetailsArtist> {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    LidarrDetailsArtistArguments _arguments;
    bool _error = false;
    final List<String> _tabTitles = [
        'Overview',
        'Albums',  
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
        if(_arguments != null && _arguments.data == null)
            await LidarrAPI.from(Database.currentProfileObject).getArtist(_arguments.artistID)
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

    Widget get _appBar => LSAppBar(title: 'Artist Details');

    Widget get _body => DefaultTabController(
        length: _tabTitles.length,
        initialIndex: 1,
        child: LSSliverAppBarTabs(
            title: _arguments.data.title,
            backgroundURI: _arguments.data.fanartURI(highRes: true),
            bottom: TabBar(
                tabs: <Widget>[
                    for(int i =0; i<_tabTitles.length; i++) Tab(
                        child: Text(
                            _tabTitles[i],
                            style: TextStyle(
                                letterSpacing: Constants.UI_LETTER_SPACING,
                            ),
                        ),
                    ),
                ],
            ),
            body: TabBarView(
                children: <Widget>[
                    LidarrDetailsOverview(data: _arguments.data),
                    LidarrDetailsAlbumList(artistID: _arguments.data.artistID),
                ],
            ),
            actions: <Widget>[
                LidarrDetailsHideButton(),
                LidarrDetailsEditButton(
                    data: _arguments.data,
                    remove: (bool withData) => _removeCallback(withData),
                ),
            ],
        ),
    );

    Future<void> _removeCallback(bool withData) async => Navigator.of(context).pop(['remove_artist', withData]);
}
