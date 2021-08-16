import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

class OverseerrUserTile extends StatelessWidget {
  final OverseerrUser user;

  OverseerrUserTile({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaTwoLineCardWithPoster(
      title: user.lunaDisplayName(),
      subtitle1: TextSpan(text: user.lunaEmail()),
      subtitle2: TextSpan(
        text: user.lunaAmountOfRequests(),
        style: TextStyle(
          color: LunaColours.accent,
          fontWeight: LunaUI.FONT_WEIGHT_BOLD,
        ),
      ),
      posterPlaceholder: LunaAssets.blankUser,
      posterHeaders: context.read<OverseerrState>().headers,
      posterUrl: user.avatar,
    );
  }
}
