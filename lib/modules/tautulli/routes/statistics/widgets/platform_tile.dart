import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliStatisticsPlatformTile extends StatelessWidget {
  final Map<String, dynamic> data;
  final double _imageDimension = 83.0;
  final double _padding = 8.0;

  const TautulliStatisticsPlatformTile({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => LunaCard(
        context: context,
        child: Row(
          children: [
            _placeholder,
            _details(context),
          ],
        ),
      );

  Widget get _placeholder => Container(
        height: _imageDimension,
        width: _imageDimension / 1.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
          image: const DecorationImage(
            image: AssetImage(LunaAssets.blankDevice),
            fit: BoxFit.cover,
          ),
        ),
      );

  Widget _details(BuildContext context) => Expanded(
        child: Padding(
          child: SizedBox(
            child: Column(
              children: [
                _title,
                _subtitle(context),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
            ),
            height: (_imageDimension - (_padding * 2)),
          ),
          padding: EdgeInsets.all(_padding),
        ),
      );

  Widget get _title => LunaText.title(
        text: data['platform'] ?? 'Unknown Platform',
        maxLines: 1,
      );

  Widget _subtitle(BuildContext context) => RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.white70,
            fontSize: LunaUI.FONT_SIZE_H3,
          ),
          children: <TextSpan>[
            TextSpan(
              text: data['total_plays'].toString() +
                  (data['total_plays'] == 1 ? ' Play' : ' Plays'),
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
            const TextSpan(text: '\n'),
            data['total_duration'] != null
                ? TextSpan(
                    text: Duration(seconds: data['total_duration'])
                        .lunaTimestampWords,
                    style: TextStyle(
                      color: context.watch<TautulliState>().statisticsType ==
                              TautulliStatsType.DURATION
                          ? LunaColours.accent
                          : null,
                      fontWeight:
                          context.watch<TautulliState>().statisticsType ==
                                  TautulliStatsType.DURATION
                              ? LunaUI.FONT_WEIGHT_BOLD
                              : null,
                    ),
                  )
                : const TextSpan(text: LunaUI.TEXT_EMDASH),
            const TextSpan(text: '\n'),
            data['last_play'] != null
                ? TextSpan(
                    text:
                        'Last Used ${DateTime.fromMillisecondsSinceEpoch(data['last_play'] * 1000)?.lunaAge ?? 'Unknown'}',
                  )
                : const TextSpan(text: LunaUI.TEXT_EMDASH)
          ],
        ),
        softWrap: false,
        maxLines: 3,
        overflow: TextOverflow.fade,
      );
}
