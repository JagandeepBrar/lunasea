import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLogsTautulliLogTile extends StatelessWidget {
    final TautulliLog log;

    TautulliLogsTautulliLogTile({
        Key key,
        @required this.log,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return LunaExpandableListTile(
            title: log.message.trim(),
            collapsedSubtitle1: _subtitle1(),
            collapsedSubtitle2: _subtitle2(),
            expandedTableContent: _tableContent(),
        );
    }

    TextSpan _subtitle1() => TextSpan(text: log.timestamp ?? LunaUI.TEXT_EMDASH);

    TextSpan _subtitle2() {
        return TextSpan(
            text: log.level ?? LunaUI.TEXT_EMDASH,
            style: TextStyle(
                color: LunaColours.accent,
                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
            ),
        );
    }
    
    List<LunaTableContent> _tableContent() {
        return [
            LunaTableContent(title: 'level', body: log.level),
            LunaTableContent(title: 'timestamp', body: log.timestamp),
            LunaTableContent(title: 'thread', body: log.thread),
        ];
    }
}
