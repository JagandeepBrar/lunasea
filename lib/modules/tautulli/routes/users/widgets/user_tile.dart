import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/datetime.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:lunasea/router/routes/tautulli.dart';

class TautulliUserTile extends StatelessWidget {
  final TautulliTableUser user;

  const TautulliUserTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: user.friendlyName,
      posterUrl: user.userThumb,
      posterHeaders: context.read<TautulliState>().headers,
      posterPlaceholderIcon: LunaIcons.USER,
      posterIsSquare: true,
      backgroundUrl: context.watch<TautulliState>().getImageURLFromPath(
            user.thumb,
            width: MediaQuery.of(context).size.width.truncate(),
          ),
      backgroundHeaders: context.read<TautulliState>().headers,
      body: [
        TextSpan(text: user.lastSeen?.asAge() ?? 'Never'),
        TextSpan(text: user.lastPlayed ?? 'Never'),
      ],
      bodyLeadingIcons: const [
        LunaIcons.WATCHED,
        LunaIcons.PLAY,
      ],
      onTap: () => TautulliRoutes.USER_DETAILS.go(params: {
        'user': user.userId!.toString(),
      }),
    );
  }
}
