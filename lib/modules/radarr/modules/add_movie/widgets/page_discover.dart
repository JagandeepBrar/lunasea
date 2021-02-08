import 'package:flutter/material.dart';

class RadarrAddMovieDiscoverPage extends StatefulWidget {
    final ScrollController scrollController;
    
    RadarrAddMovieDiscoverPage({
        Key key,
        @required this.scrollController,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrAddMovieDiscoverPage> with AutomaticKeepAliveClientMixin {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    bool get wantKeepAlive => true;

    @override
    Widget build(BuildContext context) {
        super.build(context);
        return Scaffold(
            key: _scaffoldKey,
            body: null,
        );
    }
}
