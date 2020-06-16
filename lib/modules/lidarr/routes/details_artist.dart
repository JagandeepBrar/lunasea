import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

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
    final _pageController = PageController(initialPage: 1);
    LidarrDetailsArtistArguments _arguments;
    bool _error = false;

    @override
    void initState() {
        super.initState();
        SchedulerBinding.instance.addPostFrameCallback((_) {
            _arguments = ModalRoute.of(context).settings.arguments;
            Provider.of<LidarrModel>(context, listen: false).artistNavigationIndex = 1;
            _fetch();
        });
    }

    Future<void> _fetch() async {
        setState(() => _error = false);
        if(_arguments != null) await LidarrAPI.from(Database.currentProfileObject).getArtist(_arguments.artistID)
        .then((data) {
            if(mounted) setState(() {
                _arguments.data = data;
                _error = false;
            });
        }).catchError((_) => setState(() => _error = true));
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
            ? 'Artist Details'
            : _arguments.data.title,
        actions: _arguments == null || _arguments.data == null
            ? null
            : <Widget>[
                LidarrDetailsHideButton(),
                LidarrDetailsEditButton(
                    data: _arguments.data,
                    remove: (bool withData) => _removeCallback(withData),
                ),
            ],
    );

    Widget get _bottomNavigationBar => LidarrArtistNavigationBar(pageController: _pageController);

    List<Widget> get _tabs => [
        LidarrDetailsOverview(data: _arguments.data),
        LidarrDetailsAlbumList(artistID: _arguments.data.artistID),
    ];

    Widget get _body => PageView(
        controller: _pageController,
        children: _tabs,
        onPageChanged: _onPageChanged,
    );

    void _onPageChanged(int index) => Provider.of<LidarrModel>(context, listen: false).artistNavigationIndex = index;

    Future<void> _removeCallback(bool withData) async => Navigator.of(context).pop(['remove_artist', withData]);
}
