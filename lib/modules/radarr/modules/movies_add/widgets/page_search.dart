import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMoviesAddSearchPage extends StatefulWidget {
    RadarrMoviesAddSearchPage({
        Key key,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMoviesAddSearchPage> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final ScrollController _scrollController = ScrollController();

    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar,
            body: RadarrMoviesAddSearchResults(),
        );
    }

    Widget get _appBar => LunaAppBar.empty(
        child: RadarrMoviesAddSearchSearchBar(scrollController: _scrollController),
        height: 62.0,
    );
}
