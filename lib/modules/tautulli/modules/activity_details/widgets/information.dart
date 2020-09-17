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
            ..._metadataBlock,
            ..._playerBlock,
            ..._streamBlock,
        ],
    );

    List<Widget> get _metadataBlock => _block(
        title: 'Metadata',
        children: [
            _title,
            _content('year', session.year.toString()),
            _duration,
            _content('library', session.libraryName),
            _content('user', session.friendlyName),
        ]
    );

    Widget get _title => _content(
        'title',
        [
            if(session.title != null && session.title.isNotEmpty) '${session.title}',
            if(session.parentTitle != null && session.parentTitle.isNotEmpty) '\n${session.parentTitle}',
            if(session.grandparentTitle != null && session.grandparentTitle.isNotEmpty) '\n${session.grandparentTitle}',
        ].join()
    );
    
    Widget get _duration {
        double _percent = session.progressPercent/100;
        String _progress = Duration(seconds: (session.streamDuration.inSeconds*_percent).floor()).lsDuration_timestamp();
        String _total = session.streamDuration.lsDuration_timestamp();
        return _content('duration', '$_progress/$_total (${session.progressPercent}%)');
    }

    List<Widget> get _playerBlock => _block(
        title: 'Player',
        children: [
            _content('location', session.ipAddress),
            _content('device', session.device),
            _content('platform', session.platform),
            _content('product', session.product),
            _content('player', session.player),
            _content('version', session.platformVersion),            
        ],
    );

    List<Widget> get _streamBlock => _block(
        title: 'Stream',
        children: [
            _bandwidth,
            _quality,
            _stream,
            _container,
            _video,
            _audio,
        ],
    );

    Widget get _bandwidth => _content('bandwidth', '${session.bandwidth.lsBytes_KilobytesToString(bytes: false, decimals: 1)}ps');

    Widget get _quality => _content('quality', '${session.qualityProfile} (${session.streamBitrate.lsBytes_KilobytesToString(bytes: false, decimals: 1)}ps)');

    Widget get _stream {
        String _value = '';
        switch(session.transcodeDecision) {
            case TautulliTranscodeDecision.TRANSCODE:
                String _transcodeStatus = session.transcodeThrottled ? 'Throttled' : '${session.transcodeSpeed ?? 0.0}x';
                _value = 'Transcode ($_transcodeStatus)';
                break;
            case TautulliTranscodeDecision.COPY: _value = 'Direct Stream'; break;
            case TautulliTranscodeDecision.DIRECT_PLAY: _value = 'Direct Play'; break;
            case TautulliTranscodeDecision.NULL: _value = 'Unknown Transcode Decision'; break;
        }
        return _content('stream', _value);
    }

    Widget get _container => _content(
        'container',
        [
            session.streamContainerDecision.name,
            ' (',
            session.container.toUpperCase(),
            if(session.streamContainerDecision != null && session.streamContainerDecision != TautulliTranscodeDecision.DIRECT_PLAY)
                ' ${Constants.TEXT_RARROW} ${session.streamContainer.toUpperCase()}',
            ')',
        ].join(),
    );

    Widget get _video => session.streamVideoDecision != null && session.streamVideoDecision != TautulliTranscodeDecision.NULL
        ? _content(
            'video',
            [
                session.videoDecision.name,
                ' (',
                session.videoCodec.toUpperCase(),
                ' ',
                session.videoFullResolution,
                if(session.transcodeVideoCodec.isNotEmpty) ' ${Constants.TEXT_RARROW} ',
                if(session.transcodeVideoCodec.isNotEmpty) session.transcodeVideoCodec.toUpperCase(),
                if(session.transcodeVideoCodec.isNotEmpty) ' ${session.streamVideoFullResolution}',
                ')',
            ].join(),
        )
        : Container();

    Widget get _audio => session.streamAudioDecision != null && session.streamAudioDecision != TautulliTranscodeDecision.NULL
        ? _content(
            'audio',
            [
                session.audioDecision.name,
                ' (',
                session.audioCodec.toUpperCase(),
                if(session.transcodeAudioCodec.isNotEmpty) ' ${Constants.TEXT_RARROW} ',
                if(session.transcodeAudioCodec.isNotEmpty) session.transcodeAudioCodec.toUpperCase(),
                ')',
            ].join(),
        )
        : Container();

    List<Widget> _block({
        @required String title,
        @required List<Widget> children,
    }) => [
        LSHeader(text: title),
        LSCard(
            child: Padding(
                child: Column(
                    children: children,
                ),
                padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
        ),
    ];

    Widget _content(String header, String body) => Padding(
        child: Row(
            children: [
                Expanded(
                    child: Text(
                        header.toUpperCase(),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                        ),
                    ),
                    flex: 2,
                ),
                Container(width: 16.0, height: 0.0),
                Expanded(
                    child: Text(
                        body,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                        ),
                    ),
                    flex: 5,
                ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
    );
}
