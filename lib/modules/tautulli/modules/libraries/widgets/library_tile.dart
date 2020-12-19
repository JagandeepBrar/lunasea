import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliLibrariesLibraryTile extends StatelessWidget {
    final TautulliTableLibrary library;

    TautulliLibrariesLibraryTile({
        Key key,
        @required this.library,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: library.sectionName),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                children: <TextSpan>[
                    TextSpan(text: '${library.readableCount}\n'),
                    TextSpan(text: library.plays == 1
                        ? '1 Play ${Constants.TEXT_EMDASH} '
                        : '${library.plays} Plays ${Constants.TEXT_EMDASH} ',
                    ),
                    TextSpan(text: '${library.duration.lunaTimestampWords}\n'),
                    TextSpan(
                        style: TextStyle(
                            color: LunaColours.accent,
                            fontWeight: FontWeight.w600,
                        ),
                        text: '${library.lastAccessed?.lunaAge ?? 'Unknown'}',
                    ),
                ],
            ),
            overflow: TextOverflow.fade,
            maxLines: 3,
        ),
        padContent: true,
        decoration: LunaCardDecoration(
            uri: context.watch<TautulliState>().getImageURLFromPath(library.thumb),
            headers: context.watch<TautulliState>().headers,
        ),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) => TautulliLibrariesDetailsRouter.navigateTo(context, sectionId: library.sectionId);
}
