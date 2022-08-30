import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/datetime.dart';
import 'package:lunasea/extensions/duration/timestamp.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:lunasea/router/routes/tautulli.dart';

class TautulliStatisticsMediaTile extends StatefulWidget {
  final Map<String, dynamic> data;
  final TautulliMediaType mediaType;

  const TautulliStatisticsMediaTile({
    Key? key,
    required this.data,
    required this.mediaType,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<TautulliStatisticsMediaTile> {
  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: widget.data['title'] ?? 'lunasea.Unknown'.tr(),
      body: _body(),
      onTap: _onTap,
      posterUrl: context
          .read<TautulliState>()
          .getImageURLFromPath(widget.data['thumb']),
      posterHeaders: context.watch<TautulliState>().headers,
      posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
      backgroundUrl:
          context.read<TautulliState>().getImageURLFromPath(widget.data['art']),
      backgroundHeaders: context.watch<TautulliState>().headers,
    );
  }

  List<TextSpan> _body() {
    return [
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
      widget.data['last_play'] != null
          ? TextSpan(
              text:
                  'Last Played ${DateTime.fromMillisecondsSinceEpoch(widget.data['last_play'] * 1000).asAge()}',
            )
          : const TextSpan(text: LunaUI.TEXT_EMDASH)
    ];
  }

  void _onTap() {
    TautulliRoutes.MEDIA_DETAILS.go(params: {
      'rating_key': widget.data['rating_key'].toString(),
      'media_type': widget.mediaType.value,
    });
  }
}
