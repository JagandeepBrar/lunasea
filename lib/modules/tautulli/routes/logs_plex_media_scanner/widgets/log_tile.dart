import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLogsPlexMediaScannerLogTile extends StatelessWidget {
  final TautulliPlexLog log;

  const TautulliLogsPlexMediaScannerLogTile({
    Key? key,
    required this.log,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaExpandableListTile(
      title: log.message!.trim(),
      collapsedSubtitles: [
        _subtitle1(),
        _subtitle2(),
      ],
      expandedTableContent: _tableContent(),
    );
  }

  TextSpan _subtitle1() => TextSpan(text: log.timestamp ?? LunaUI.TEXT_EMDASH);

  TextSpan _subtitle2() {
    return TextSpan(
      text: log.level ?? LunaUI.TEXT_EMDASH,
      style: const TextStyle(
        color: LunaColours.accent,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
      ),
    );
  }

  List<LunaTableContent> _tableContent() {
    return [
      LunaTableContent(title: 'level', body: log.level),
      LunaTableContent(title: 'timestamp', body: log.timestamp),
    ];
  }
}
