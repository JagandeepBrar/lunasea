import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliStatisticsRecentlyWatchedTile extends StatelessWidget {
  final Map<String, dynamic> data;
  final double _imageDimension = 83.0;
  final double _padding = 8.0;

  const TautulliStatisticsRecentlyWatchedTile({
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
        decoration: data['art'] != null && (data['art'] as String).isNotEmpty
            ? LunaCardDecoration(
                uri: context.watch<TautulliState>().getImageURLFromPath(
                      data['art'],
                      width: MediaQuery.of(context).size.width.truncate(),
                    ),
                headers: context
                    .watch<TautulliState>()
                    .headers
                    .cast<String, String>(),
              )
            : null,
      );

  Widget _poster(BuildContext context) => LunaNetworkImage(
        context: context,
        url: context.watch<TautulliState>().getImageURLFromPath(data['thumb']),
        headers: context.watch<TautulliState>().headers.cast<String, String>(),
        placeholderIcon: LunaIcons.VIDEO_CAM,
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
        text: data['title'],
        maxLines: 1,
      );

  Widget _subtitle(BuildContext context) => RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.white70,
            fontSize: LunaUI.FONT_SIZE_H3,
          ),
          children: <TextSpan>[
            TextSpan(text: data['friendly_name'] ?? 'Unknown User'),
            const TextSpan(text: '\n'),
            data['player'] != null
                ? TextSpan(text: data['player'])
                : const TextSpan(text: LunaUI.TEXT_EMDASH),
            const TextSpan(text: '\n'),
            data['last_watch'] != null
                ? TextSpan(
                    text:
                        'Watched ${DateTime.fromMillisecondsSinceEpoch(data['last_watch'] * 1000)?.lunaAge ?? 'Unknown'}',
                  )
                : const TextSpan(text: LunaUI.TEXT_EMDASH)
          ],
        ),
        softWrap: false,
        maxLines: 3,
        overflow: TextOverflow.fade,
      );

  Future<void> _onTap(BuildContext context) async =>
      TautulliMediaDetailsRouter().navigateTo(context,
          ratingKey: data['rating_key'],
          mediaType: TautulliMediaType.NULL.from(data['media_type']));
}
