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
        subtitle: [
            sessions,
            bandwidth,
        ].join('\n'),
    );

    String get sessions {
        String value = 'Sessions: ';
        value += [
            if((activity.streamCountDirectPlay ?? 0) > 0) '${activity.streamCountDirectPlay} ${activity.streamCountDirectPlay == 1 ? 'Direct Play' : 'Direct Plays'}',
            if((activity.streamCountDirectStream ?? 0) > 0) '${activity.streamCountDirectStream} ${activity.streamCountDirectStream == 1 ? 'Direct Stream' : 'Direct Streams'}',
            if((activity.streamCountTranscode ?? 0) > 0) '${activity.streamCountTranscode} ${activity.streamCountTranscode == 1 ? 'Transcode' : 'Transcodes'}',
        ].join(', ');
        return value;
    }

    String get bandwidth {
        String value = 'Bandwidth: ${activity.totalBandwidth?.lunaKilobytesToString(bytes: false, decimals: 1) ?? '0.0'}ps (';
        value += [
            if((activity.lanBandwidth ?? 0) > 0) 'LAN: ${activity.lanBandwidth.lunaKilobytesToString(bytes: false, decimals: 1)}ps',
            if((activity.wanBandwidth ?? 0) > 0) 'WAN: ${activity.wanBandwidth.lunaKilobytesToString(bytes: false, decimals: 1)}ps',
        ].join(', ');
        value += ')';
        return value;
    }
}
