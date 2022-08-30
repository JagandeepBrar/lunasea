import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/datetime.dart';
import 'package:lunasea/extensions/duration/timestamp.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:lunasea/router/routes/tautulli.dart';

class TautulliStatisticsUserTile extends StatefulWidget {
  final Map<String, dynamic> data;

  const TautulliStatisticsUserTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliStatisticsUserTile> {
  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: widget.data['friendly_name'] ?? 'Unknown User',
      body: _body(),
      posterUrl: context
          .watch<TautulliState>()
          .getImageURLFromPath(widget.data['user_thumb']),
      posterHeaders: context.watch<TautulliState>().headers,
      posterIsSquare: true,
      posterPlaceholderIcon: LunaIcons.USER,
      onTap: _onTap,
    );
  }

  List<TextSpan> _body() {
    return [
      TextSpan(
        children: [
          TextSpan(
            text: widget.data['total_plays'].toString() +
                (widget.data['total_plays'] == 1 ? ' Play' : ' Plays'),
            style: TextStyle(
              color: context.watch<TautulliState>().statisticsType ==
                      TautulliStatsType.PLAYS
                  ? LunaColours.accent
                  : null,
              fontWeight: context.watch<TautulliState>().statisticsType ==
                      TautulliStatsType.PLAYS
                  ? LunaUI.FONT_WEIGHT_BOLD
                  : null,
            ),
          ),
          TextSpan(text: LunaUI.TEXT_BULLET.pad()),
          widget.data['total_duration'] != null
              ? TextSpan(
                  text: Duration(seconds: widget.data['total_duration'])
                      .asWordsTimestamp(),
                  style: TextStyle(
                    color: context.watch<TautulliState>().statisticsType ==
                            TautulliStatsType.DURATION
                        ? LunaColours.accent
                        : null,
                    fontWeight: context.watch<TautulliState>().statisticsType ==
                            TautulliStatsType.DURATION
                        ? LunaUI.FONT_WEIGHT_BOLD
                        : null,
                  ),
                )
              : const TextSpan(text: LunaUI.TEXT_EMDASH),
        ],
      ),
      widget.data['last_play'] != null
          ? TextSpan(
              text:
                  'Last Streamed ${DateTime.fromMillisecondsSinceEpoch(widget.data['last_play'] * 1000).asAge()}',
            )
          : const TextSpan(text: LunaUI.TEXT_EMDASH)
    ];
  }

  Future<void> _onTap() async {
    TautulliRoutes.USER_DETAILS.go(params: {
      'user': widget.data['user_id']!.toString(),
    });
  }
}
