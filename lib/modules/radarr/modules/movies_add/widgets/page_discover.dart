import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class RadarrMoviesAddDiscoverPage extends StatefulWidget {
    RadarrMoviesAddDiscoverPage({
        Key key,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMoviesAddDiscoverPage> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: LSGenericMessage(text: 'Coming Soon'),
        );
    }
}
