import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrReleasesTile extends StatefulWidget {
    final RadarrRelease release;
    
    RadarrReleasesTile({
        @required this.release,
        Key key,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrReleasesTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LunaText.title(text: widget.release.title),
    );
}
