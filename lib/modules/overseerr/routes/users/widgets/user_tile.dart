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
      title: user.displayName ?? 'overseerr.UnknownUser'.tr(),
      subtitle1: TextSpan(text: 'Placeholder 1'),
      subtitle2: TextSpan(text: 'Placeholder 2'),
      posterPlaceholder: LunaAssets.blankUser,
      posterHeaders: context.read<OverseerrState>().headers,
      posterUrl: user.avatar,
    );
  }
}
