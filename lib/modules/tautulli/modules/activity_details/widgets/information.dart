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
            TautulliActivityDetailsTerminateSession(session: session),
            _metadataBlock,
            _playerBlock,
            _streamBlock,
        ],
    );

    Widget get _metadataBlock => LSTableBlock(
        title: 'Metadata',
        children: [
            LSTableContent(title: 'title', body: session.lsFullTitle),
            LSTableContent(title: 'year', body: session.year.toString()),
            LSTableContent(title: 'duration', body: session.lsDuration),
            LSTableContent(title: 'eta', body: session.lunaETA),
            LSTableContent(title: 'library', body: session.libraryName),
            LSTableContent(title: 'user', body: session.friendlyName),
        ]
    );

    Widget get _playerBlock => LSTableBlock(
        title: 'Player',
        children: [
            LSTableContent(title: 'location', body: session.ipAddress),
            LSTableContent(title: 'device', body: session.device),
            LSTableContent(title: 'platform', body: session.platform),
            LSTableContent(title: 'product', body: session.product),
            LSTableContent(title: 'player', body: session.player),
            LSTableContent(title: 'version', body: session.platformVersion),            
        ],
    );

    Widget get _streamBlock => LSTableBlock(
        title: 'Stream',
        children: [
            LSTableContent(title: 'bandwidth', body: session.lsBandwidth),
            LSTableContent(title: 'quality', body: session.lsQuality),
            LSTableContent(title: 'stream', body: session.lsStream),
            LSTableContent(title: 'container', body: session.lsContainer),
            if(session.streamVideoDecision != null && session.streamVideoDecision != TautulliTranscodeDecision.NULL)
                LSTableContent(title: 'video', body: session.lsVideo),
            if(session.streamAudioDecision != null && session.streamAudioDecision != TautulliTranscodeDecision.NULL)
                LSTableContent(title: 'audio', body: session.lsAudio),
        ],
    );
}
