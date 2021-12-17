import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliLibrariesLibraryTile extends StatelessWidget {
  final TautulliTableLibrary library;

  const TautulliLibrariesLibraryTile({
    Key key,
    @required this.library,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _plays = library.plays;
    return LunaBlock(
      title: library.sectionName,
      body: [
        TextSpan(text: library.readableCount),
        TextSpan(
          children: [
            TextSpan(text: _plays == 1 ? '1 Play' : '$_plays Plays'),
            TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
            TextSpan(text: library.duration.lunaTimestampWords),
          ],
        ),
        TextSpan(
          style: const TextStyle(
            color: LunaColours.accent,
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          ),
          text: library.lastAccessed?.lunaAge ?? 'Unknown',
        ),
      ],
      backgroundUrl:
          context.watch<TautulliState>().getImageURLFromPath(library.thumb),
      backgroundHeaders: context.watch<TautulliState>().headers,
      onTap: () async => TautulliLibrariesDetailsRouter().navigateTo(
        context,
        sectionId: library.sectionId,
      ),
    );
  }
}
