import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
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
            _metadataBlock,
            _sessionBlock,
            _playerBlock,
        ],
    );

    Widget get _metadataBlock => LSTableBlock(
        title: 'Metadata',
        children: [
            LSTableContent(title: 'status', body: history.lsStatus),
            LSTableContent(title: 'title', body: history.lsFullTitle),
            LSTableContent(title: 'year', body: history.year.toString()),
            LSTableContent(title: 'user', body: history.friendlyName),
        ],
    );

    Widget get _sessionBlock => LSTableBlock(
        title: 'Session',
        children: [
            LSTableContent(title: 'state', body: history.lsState),
            LSTableContent(title: 'date', body: DateFormat('yyyy-MM-dd').format(history.date)),
            LSTableContent(title: 'started', body: history.date.lunaTime),
            LSTableContent(title: 'stopped', body: history.state == null ? history.stopped.lunaTime : Constants.TEXT_EMDASH),
            LSTableContent(title: 'paused', body: history.pausedCounter.lunaTimestampWords),
        ],
    );

    Widget get _playerBlock => LSTableBlock(
        title: 'Player',
        children: [
            LSTableContent(title: 'location', body: history.ipAddress),
            LSTableContent(title: 'platform', body: history.platform),
            LSTableContent(title: 'product', body: history.product),
            LSTableContent(title: 'player', body: history.player),
        ],
    );
}
