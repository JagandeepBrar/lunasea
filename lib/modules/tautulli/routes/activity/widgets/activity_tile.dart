import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TautulliActivityTile extends StatelessWidget {
  final TautulliSession session;
  final bool disableOnTap;

  const TautulliActivityTile({
    Key key,
    @required this.session,
    this.disableOnTap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaFiveLineCardWithPoster(
      title: session.lunaTitle,
      posterUrl: session.lunaArtworkPath(context),
      posterHeaders: context.read<TautulliState>().headers,
      posterPlaceholder: LunaAssets.blankVideo,
      backgroundUrl: context.watch<TautulliState>().getImageURLFromPath(
            session.art,
            width: MediaQuery.of(context).size.width.truncate(),
          ),
      subtitle1: _subtitle1(),
      subtitle2: _subtitle2(),
      customSubtitle3: _subtitle3(),
      customSubtitle4: _subtitle4(),
      onTap: disableOnTap ? null : () async => _enterDetails(context),
    );
  }

  TextSpan _subtitle1() {
    if (session.mediaType == TautulliMediaType.EPISODE) {
      return TextSpan(
        children: [
          TextSpan(text: session.parentTitle),
          TextSpan(text: LunaUI.TEXT_EMDASH.lunaPad()),
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
          TextSpan(text: LunaUI.TEXT_EMDASH.lunaPad()),
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
    return TextSpan(text: session.lunaTranscodeDecision);
  }

  Widget _subtitle3() {
    return Row(
      children: [
        Container(
          child: Icon(
            session.lunaSessionStateIcon,
            size: LunaUI.FONT_SIZE_H3,
            color: Colors.white70,
          ),
          width: 16.0 + session.lunaSessionStateIconOffset,
          transform: Matrix4.translationValues(
              session.lunaSessionStateIconOffset, 0.0, 0.0),
        ),
        LunaText.subtitle(text: session.lunaFriendlyName),
      ],
    );
  }

  Widget _subtitle4() {
    return SizedBox(
      height: LunaListTile.PER_LINE_HEIGHT,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          LinearPercentIndicator(
            percent: session.lunaTranscodeProgress,
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            progressColor: LunaColours.splash.withOpacity(0.30),
            backgroundColor: Colors.transparent,
            lineHeight: 4.0,
          ),
          LinearPercentIndicator(
            percent: session.lunaProgressPercent,
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            progressColor: LunaColours.accent,
            backgroundColor: LunaColours.accent.withOpacity(0.15),
            lineHeight: 4.0,
          ),
        ],
      ),
    );
  }

  Future<void> _enterDetails(BuildContext context) async =>
      TautulliActivityDetailsRouter().navigateTo(
        context,
        sessionId: session.sessionId,
      );
}
