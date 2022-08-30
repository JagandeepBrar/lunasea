import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:lunasea/router/routes/tautulli.dart';

class TautulliLibrariesDetailsUserStatsTile extends StatelessWidget {
  final TautulliLibraryUserStats user;

  const TautulliLibrariesDetailsUserStatsTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      posterUrl:
          context.watch<TautulliState>().getImageURLFromPath(user.userThumb),
      posterHeaders:
          context.watch<TautulliState>().headers.cast<String, String>(),
      posterPlaceholderIcon: LunaIcons.USER,
      title: user.friendlyName,
      body: [
        TextSpan(
            text: user.totalPlays == 1 ? '1 Play' : '${user.totalPlays} Plays'),
        TextSpan(text: user.userId.toString()),
      ],
      bodyLeadingIcons: const [
        LunaIcons.PLAY,
        LunaIcons.USER,
      ],
      onTap: () async => _onTap(context),
      posterIsSquare: true,
    );
  }

  void _onTap(BuildContext context) {
    TautulliRoutes.USER_DETAILS.go(params: {
      'user': user.userId!.toString(),
    });
  }
}
