import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:lunasea/router/routes/tautulli.dart';

class TautulliActivityTile extends StatelessWidget {
  final TautulliSession session;
  final bool disableOnTap;

  const TautulliActivityTile({
    Key? key,
    required this.session,
    this.disableOnTap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: session.lunaTitle,
      posterUrl: session.lunaArtworkPath(context),
      posterHeaders: context.read<TautulliState>().headers,
      posterPlaceholderIcon: LunaIcons.VIDEO_CAM,
      backgroundUrl: context.watch<TautulliState>().getImageURLFromPath(
            session.art,
            width: MediaQuery.of(context).size.width.truncate(),
          ),
      body: [
        _subtitle1(),
        _subtitle2(),
        _subtitle3(),
      ],
      bottom: _bottomWidget(),
      bottomHeight: LunaLinearPercentIndicator.height,
      trailing: LunaIconButton(icon: session.lunaSessionStateIcon),
      onTap: disableOnTap ? null : () async => _enterDetails(context),
    );
  }

  TextSpan _subtitle1() {
    if (session.mediaType == TautulliMediaType.EPISODE) {
      return TextSpan(
        children: [
          TextSpan(text: session.parentTitle),
          TextSpan(text: LunaUI.TEXT_BULLET.pad()),
          TextSpan(
              text: 'tautulli.Episode'.tr(args: [
            session.mediaIndex?.toString() ?? LunaUI.TEXT_EMDASH
          ])),
          const TextSpan(text: ': '),
          TextSpan(
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
            text: session.title ?? LunaUI.TEXT_EMDASH,
          ),
        ],
      );
    }
    if (session.mediaType == TautulliMediaType.MOVIE) {
      return TextSpan(text: session.year.toString());
    }
    if (session.mediaType == TautulliMediaType.TRACK) {
      return TextSpan(
        children: [
          TextSpan(text: session.parentTitle),
          TextSpan(text: LunaUI.TEXT_EMDASH.pad()),
          TextSpan(
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
            text: session.title,
          ),
        ],
      );
    }
    if (session.mediaType == TautulliMediaType.LIVE) {
      return TextSpan(text: session.title);
    }
    return const TextSpan(text: LunaUI.TEXT_EMDASH);
  }

  TextSpan _subtitle2() {
    return TextSpan(text: session.lunaFriendlyName);
  }

  TextSpan _subtitle3() {
    return TextSpan(
      text: session.formattedStream(),
      style: const TextStyle(
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        color: LunaColours.accent,
      ),
    );
  }

  Widget _bottomWidget() {
    return SizedBox(
      height: LunaLinearPercentIndicator.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          LunaLinearPercentIndicator(
            percent: session.lunaTranscodeProgress,
            progressColor: LunaColours.accent.withOpacity(
              LunaUI.OPACITY_SPLASH,
            ),
            backgroundColor: Colors.transparent,
          ),
          LunaLinearPercentIndicator(
            percent: session.lunaProgressPercent,
            progressColor: LunaColours.accent,
            backgroundColor: LunaColours.grey.withOpacity(
              LunaUI.OPACITY_SPLASH,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _enterDetails(BuildContext context) async {
    TautulliRoutes.ACTIVITY_DETAILS.go(params: {
      'session': session.sessionKey.toString(),
    });
  }
}
