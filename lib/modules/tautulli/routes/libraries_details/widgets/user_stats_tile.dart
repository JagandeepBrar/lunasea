import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLibrariesDetailsUserStatsTile extends StatelessWidget {
  final TautulliLibraryUserStats user;

  const TautulliLibrariesDetailsUserStatsTile({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaThreeLineCardWithPoster(
      posterUrl:
          context.watch<TautulliState>().getImageURLFromPath(user.userThumb),
      posterHeaders:
          context.watch<TautulliState>().headers.cast<String, String>(),
      posterPlaceholder: LunaAssets.blankUser,
      title: user.friendlyName,
      customSubtitle1: _subtitle1(),
      customSubtitle2: _subtitle2(),
      onTap: () async => _onTap(context),
      posterIsSquare: true,
    );
  }

  Widget _subtitle1() {
    return Row(
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
            text: user.totalPlays == 1 ? '1 Play' : '${user.totalPlays} Plays',
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget _subtitle2() {
    return Row(
      children: [
        const Padding(
          child: Icon(
            Icons.person_rounded,
            size: LunaUI.FONT_SIZE_H3,
          ),
          padding: EdgeInsets.only(right: 6.0),
        ),
        Expanded(
          child: LunaText.subtitle(
            text: user.userId.toString(),
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Future<void> _onTap(BuildContext context) =>
      TautulliUserDetailsRouter().navigateTo(
        context,
        userId: user.userId,
      );
}
