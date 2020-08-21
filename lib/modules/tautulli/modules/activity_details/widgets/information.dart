import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliActivityDetailsInformation extends StatelessWidget {
    final TautulliSession session;

    TautulliActivityDetailsInformation({
        Key key,
        @required this.session,
    }): super(key: key);

    @override
    Widget build(BuildContext context) => Column(
        children: [
            Text('test'),
        ],
    );     
}
