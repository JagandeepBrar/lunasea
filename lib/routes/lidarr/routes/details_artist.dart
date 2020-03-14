import 'package:flutter/material.dart';
import 'package:lunasea/widgets.dart';

class LidarrDetailsArtist extends StatefulWidget {
    static const ROUTE_NAME = '/lidarr/details/artist';

    @override
    State<LidarrDetailsArtist> createState() => _State();
}

class _State extends State<LidarrDetailsArtist> {
    @override
    Widget build(BuildContext context) => Scaffold(
        body: Text('Details Artist'),
        appBar: _appBar,
    );

    Widget get _appBar => LSAppBar(title: 'Details Artist');
}
