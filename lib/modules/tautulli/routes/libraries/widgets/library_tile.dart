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
    return LunaListTile(
      context: context,
      title: LunaText.title(text: library.sectionName),
      subtitle: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.white70,
            fontSize: LunaUI.FONT_SIZE_SUBTITLE,
          ),
          children: <TextSpan>[
            TextSpan(text: '${library.readableCount}\n'),
            TextSpan(
              text: library.plays == 1
                  ? '1 Play ${LunaUI.TEXT_EMDASH} '
                  : '${library.plays} Plays ${LunaUI.TEXT_EMDASH} ',
            ),
            TextSpan(text: '${library.duration.lunaTimestampWords}\n'),
            TextSpan(
              style: const TextStyle(
                color: LunaColours.accent,
                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
              ),
              text: library.lastAccessed?.lunaAge ?? 'Unknown',
            ),
          ],
        ),
        overflow: TextOverflow.fade,
        maxLines: 3,
      ),
      height: LunaListTile.itemHeightExtended(3),
      contentPadding: true,
      decoration: LunaCardDecoration(
        uri: context.watch<TautulliState>().getImageURLFromPath(library.thumb),
        headers: context.watch<TautulliState>().headers,
      ),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) => TautulliLibrariesDetailsRouter()
      .navigateTo(context, sectionId: library.sectionId);
}
