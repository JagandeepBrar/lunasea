import 'package:flutter/material.dart';
import 'package:lunasea/widgets.dart';

class LidarrDetailsAlbumList extends StatefulWidget {
    @override
    State<LidarrDetailsAlbumList> createState() => _State();
}

class _State extends State<LidarrDetailsAlbumList> {
    @override
    Widget build(BuildContext context) => LSListViewBuilder(
        itemCount: 1,
        itemBuilder: (context, index) => Text('Hello'),
        padBottom: true,
    );
}