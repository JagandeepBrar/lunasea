import 'package:flutter/material.dart';
import 'package:tautulli/tautulli.dart';
import 'package:lunasea/core.dart';

class TautulliActivityStatus extends StatelessWidget {
    final TautulliActivity activity;

    TautulliActivityStatus({
        @required this.activity,
        Key key,
    }): super(key: key);

    @override
    Widget build(BuildContext context) => LSHeader(
        text: '${activity.streamCount} ${activity.streamCount == 1 ? 'Session' : 'Sessions'}',
        subtitle: 'Total Bandwidth Usage: ${activity.totalBandwidth.lsBytes_KilobytesToString(bytes: false, decimals: 1)}ps',
    );
}
