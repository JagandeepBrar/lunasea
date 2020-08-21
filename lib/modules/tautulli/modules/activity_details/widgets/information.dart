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
    Widget build(BuildContext context) => LSListView(
        children: [
            TautulliActivityTile(session: session, disableOnTap: true),
            LSDivider(),
            _content('Header', 'Body'),
            _content('Header', 'Body'),
        ],
    );

    Widget _content(String header, String body) => Padding(
        child: Row(
            children: [
                Expanded(
                    child: Text(
                        header,
                        textAlign: TextAlign.start,
                        style: TextStyle(),
                    ),
                    flex: 1,
                ),
                Container(width: 10.0, height: 0.0),
                Expanded(
                    child: Text(
                        body,
                        textAlign: TextAlign.start,
                        style: TextStyle(),
                    ),
                    flex: 2,
                ),
            ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    );
}
