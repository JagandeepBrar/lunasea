import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:tautulli/tautulli.dart';

class TautulliHistoryDetailsInformation extends StatelessWidget {
    final TautulliHistoryRecord history;

    TautulliHistoryDetailsInformation({
        Key key,
        @required this.history,
    }): super(key: key);

    @override
    Widget build(BuildContext context) => LSListView(
        children: [
            ..._metadataBlock,
            ..._sessionBlock,
            ..._playerBlock,
        ],
    );

    List<Widget> get _metadataBlock => _block(
        title: 'Metadata',
        children: <Widget>[
            _status,
            _title,
            _content('year', history.year.toString()),
            _content('user', history.friendlyName),
        ],
    );

    List<Widget> get _sessionBlock => _block(
        title: 'Session',
        children: <Widget>[
            _state,
            _content('date', DateFormat('yyyy-MM-dd').format(history.date)),
            _content('started', history.date.lsDateTime_time),
            _content('stopped', history.state == null ? history.stopped.lsDateTime_time : Constants.TEXT_EMDASH),
            _content('paused', history.pausedCounter.lsDuration_fullTimestamp()),
        ],
    );

    List<Widget> get _playerBlock => _block(
        title: 'Player',
        children: <Widget>[
            _content('location', history.ipAddress),
            _content('platform', history.platform),
            _content('product', history.product),
            _content('player', history.player),
            //_content('quality', history.)
        ],
    );

    Widget get _status {
        String _progress = 'Unknown';
        if(history.watchedStatus != null) switch(history.watchedStatus) {
            case TautulliWatchedStatus.UNWATCHED: _progress = 'Incompleted'; break;
            case TautulliWatchedStatus.PARTIALLY_WATCHED: _progress = 'Partially Completed'; break;
            case TautulliWatchedStatus.WATCHED: _progress = 'Completed'; break;
        }
        return _content(
            'status',
            _progress,
        );
    }

    Widget get _state {
        String _status = 'Finished';
        if(history.state != null) switch(history.state) {
            case TautulliSessionState.PLAYING: _status = 'Playing'; break;
            case TautulliSessionState.PAUSED: _status = 'Paused'; break;
            case TautulliSessionState.BUFFERING: _status = 'Buffering'; break;
            case TautulliSessionState.NULL: _status = 'Finished'; break;
        }
        return _content(
            'state',
            _status,
        );
    }

    Widget get _title => _content(
        'title',
        [
            if(history.title != null && history.title.isNotEmpty) '${history.title}',
            if(history.parentTitle != null && history.parentTitle.isNotEmpty) '\n${history.parentTitle}',
            if(history.grandparentTitle != null && history.grandparentTitle.isNotEmpty) '\n${history.grandparentTitle}',
        ].join()
    );

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
                        ),
                    ),
                    flex: 2,
                ),
                Container(width: 16.0, height: 0.0),
                Expanded(
                    child: Text(
                        body,
                        textAlign: TextAlign.start,
                        style: TextStyle(),
                    ),
                    flex: 5,
                ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
    );
}
