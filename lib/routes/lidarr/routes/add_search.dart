import 'package:flutter/material.dart';
import 'package:lunasea/widgets.dart';

class LidarrAddSearch extends StatefulWidget {
    static const ROUTE_NAME = '/lidarr/add/search';

    @override
    State<LidarrAddSearch> createState() => _State();
}

class _State extends State<LidarrAddSearch> {
    @override
    Widget build(BuildContext context) => Scaffold(
        body: Text('search'),
        appBar: _appBar,
    );

    Widget get _appBar => LSAppBar(title: 'Add Artist');
}
