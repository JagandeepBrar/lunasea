import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/overseerr.dart';

class OverseerrUserTile extends StatelessWidget {
  final OverseerrUser user;

  const OverseerrUserTile({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: user.lunaDisplayName(),
      body: [
        TextSpan(text: user.lunaEmail()),
        TextSpan(
          text: user.lunaAmountOfRequests(),
          style: const TextStyle(
            color: LunaColours.accent,
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          ),
        ),
      ],
      posterPlaceholderIcon: LunaIcons.USER,
      posterHeaders: context.read<OverseerrState>().headers,
      posterUrl: user.avatar,
      posterIsSquare: true,
    );
  }
}
