import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliUserTile extends StatelessWidget {
  final TautulliTableUser user;
  final double _imageDimension = 70.0;
  final double _padding = 8.0;

  const TautulliUserTile({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => LunaCard(
        context: context,
        child: InkWell(
          borderRadius: BorderRadius.circular(LunaUI.BORDER_RADIUS),
          child: Row(
            children: [
              _userThumb(context),
              _details,
            ],
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          onTap: () async => _enterDetails(context),
        ),
        decoration: user.thumb != null && user.thumb.isNotEmpty
            ? LunaCardDecoration(
                uri: context.watch<TautulliState>().getImageURLFromPath(
                      user.thumb,
                      width: MediaQuery.of(context).size.width.truncate(),
                    ),
                headers: context
                    .watch<TautulliState>()
                    .headers
                    .cast<String, String>(),
              )
            : null,
      );

  Widget _userThumb(BuildContext context) => LunaNetworkImage(
        url: user.userThumb,
        placeholderAsset: LunaAssets.blankUser,
        height: _imageDimension,
        width: _imageDimension,
      );

  Widget get _details => Expanded(
        child: Padding(
          child: SizedBox(
            child: Column(
              children: [
                _title,
                _lastPlayedTime,
                _lastPlayedContent,
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

  Widget get _title => LunaText.title(text: user.friendlyName);

  Widget get _lastPlayedTime => Row(
        children: [
          const Padding(
            child: Icon(
              Icons.visibility_rounded,
              size: LunaUI.FONT_SIZE_H3,
            ),
            padding: EdgeInsets.only(right: 6.0),
          ),
          Expanded(
            child: LunaText.subtitle(
              text: user.lastSeen?.lunaAge ?? 'Never',
              maxLines: 1,
            ),
          ),
        ],
      );

  Widget get _lastPlayedContent => Row(
        children: [
          const Padding(
            child: Icon(
              Icons.play_arrow_rounded,
              size: LunaUI.FONT_SIZE_H3,
            ),
            padding: EdgeInsets.only(right: 6.0),
          ),
          Expanded(
            child: LunaText.subtitle(
              text: user.lastPlayed ?? 'Never',
              maxLines: 1,
            ),
          ),
        ],
      );

  Future<void> _enterDetails(BuildContext context) async =>
      TautulliUserDetailsRouter().navigateTo(context, userId: user.userId);
}
