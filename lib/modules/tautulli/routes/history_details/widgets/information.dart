import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/datetime.dart';
import 'package:lunasea/extensions/duration/timestamp.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliHistoryDetailsInformation extends StatelessWidget {
  final TautulliHistoryRecord history;
  final ScrollController scrollController;

  const TautulliHistoryDetailsInformation({
    Key? key,
    required this.history,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaListView(
      controller: scrollController,
      children: [
        const LunaHeader(text: 'Metadata'),
        _metadataBlock(),
        const LunaHeader(text: 'Session'),
        _sessionBlock(),
        const LunaHeader(text: 'Player'),
        _playerBlock(),
      ],
    );
  }

  Widget _metadataBlock() {
    return LunaTableCard(
      content: [
        LunaTableContent(title: 'status', body: history.lsStatus),
        LunaTableContent(title: 'title', body: history.lsFullTitle),
        if (history.year != null)
          LunaTableContent(title: 'year', body: history.year.toString()),
        LunaTableContent(title: 'user', body: history.friendlyName),
      ],
    );
  }

  Widget _sessionBlock() {
    return LunaTableCard(
      content: [
        LunaTableContent(title: 'state', body: history.lsState),
        LunaTableContent(
            title: 'date',
            body: DateFormat('yyyy-MM-dd').format(history.date!)),
        LunaTableContent(title: 'started', body: history.date!.asTimeOnly()),
        LunaTableContent(
            title: 'stopped',
            body: history.state == null
                ? history.stopped!.asTimeOnly()
                : LunaUI.TEXT_EMDASH),
        LunaTableContent(
            title: 'paused', body: history.pausedCounter!.asWordsTimestamp()),
      ],
    );
  }

  Widget _playerBlock() {
    return LunaTableCard(
      content: [
        LunaTableContent(title: 'location', body: history.ipAddress),
        LunaTableContent(title: 'platform', body: history.platform),
        LunaTableContent(title: 'product', body: history.product),
        LunaTableContent(title: 'player', body: history.player),
      ],
    );
  }
}
