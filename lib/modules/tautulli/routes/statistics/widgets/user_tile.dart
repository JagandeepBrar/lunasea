import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliStatisticsUserTile extends StatelessWidget {
  final Map<String, dynamic> data;
  final double _imageDimension = 83.0;
  final double _padding = 8.0;

  const TautulliStatisticsUserTile({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => LunaCard(
        context: context,
        child: InkWell(
          borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
          child: Row(
            children: [
              _poster(context),
              _details(context),
            ],
          ),
          onTap: () async => _onTap(context),
        ),
      );

  Widget _poster(BuildContext context) => LunaNetworkImage(
        url: context
            .watch<TautulliState>()
            .getImageURLFromPath(data['user_thumb']),
        headers: context.watch<TautulliState>().headers.cast<String, String>(),
        placeholderAsset: LunaAssets.blankUser,
        height: _imageDimension,
        width: _imageDimension / 1.5,
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
        text: data['friendly_name'] ?? 'Unknown User',
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
                        'Last Streamed ${DateTime.fromMillisecondsSinceEpoch(data['last_play'] * 1000)?.lunaAge ?? 'Unknown'}',
                  )
                : const TextSpan(text: LunaUI.TEXT_EMDASH)
          ],
        ),
        softWrap: false,
        maxLines: 3,
        overflow: TextOverflow.fade,
      );

  Future<void> _onTap(BuildContext context) async {
    TautulliTableUser _user = await context.watch<TautulliState>().users.then(
          (users) => users.users.firstWhere(
            (user) => user.userId == data['user_id'] ?? -1,
            orElse: () => null,
          ),
        );
    if (_user == null) {
      showLunaErrorSnackBar(
        title: 'User Not Found',
        message: 'Unable to find the Tautulli user',
      );
    } else {
      TautulliUserDetailsRouter().navigateTo(context, userId: _user.userId);
    }
  }
}
