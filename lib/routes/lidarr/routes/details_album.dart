import 'package:flutter/material.dart';
import 'package:lunasea/widgets.dart';

class LidarrDetailsAlbum extends StatefulWidget {
    static const ROUTE_NAME = '/lidarr/details/album';

    @override
    State<LidarrDetailsAlbum> createState() => _State();
}

class _State extends State<LidarrDetailsAlbum> {
    @override
    Widget build(BuildContext context) => Scaffold(
        body: Text('Details Album'),
        appBar: _appBar,
    );

    Widget get _appBar => LSAppBar(title: 'Details Album');
}
