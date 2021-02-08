import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieSearchPage extends StatefulWidget {
    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrAddMovieSearchPage> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            appBar: _appBar,
            body: RadarrAddMovieSearchResultsList(),
        );
    }

    Widget get _appBar => LunaAppBar.empty(
        child: RadarrAddMovieSearchSearchBar(scrollController: context.read<RadarrState>().scrollController),
        height: 62.0,
    );
}
