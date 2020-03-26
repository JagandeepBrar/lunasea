import 'dart:math';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:lunasea/core.dart';
import '../../nzbget.dart';

class NZBGetQueueTile extends StatelessWidget {
    final NZBGetQueueData data;

    NZBGetQueueTile({
        @required this.data,
        Key key,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(
            text: data.name,
            darken: data.paused,
        ),
        subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
                Padding(
                    child: LinearPercentIndicator(
                        percent: min(1.0, max(0, data.percentageDone/100)),
                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                        progressColor: data.paused ? LSColors.accent.withOpacity(0.30) : LSColors.accent,
                        backgroundColor: data.paused ? LSColors.accent.withOpacity(0.05) : LSColors.accent.withOpacity(0.15),
                        lineHeight: 4.0,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 6.0),
                ),
                LSSubtitle(
                    text: data.subtitle,
                    darken: data.paused,
                ),
            ],
        ),
        trailing: LSIconButton(
            icon: Icons.more_vert,
            onPressed: () async => _handlePopup(context),
            color: data.paused ? Colors.white30 : Colors.white,
        ),
    );

    Future<void> _handlePopup(BuildContext context) async {

    }
}
