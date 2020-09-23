import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliSyncedItemTile extends StatelessWidget {
    final TautulliSyncedItem syncedItem;

    TautulliSyncedItemTile({
        Key key,
        @required this.syncedItem,
    }): super(key: key);

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: syncedItem.syncTitle),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,  
                ),
                children: [
                    TextSpan(
                        text: (syncedItem.state ?? 'Unknown').lsLanguage_Capitalize(),
                        style: TextStyle(
                            color: LunaColours.accent,
                            fontWeight: FontWeight.w600,
                        ),
                    ),
                    TextSpan(text: '\t${Constants.TEXT_EMDASH}\t'),
                    TextSpan(text: (syncedItem.metadataType ?? 'Unknown').lsLanguage_Capitalize()),
                    TextSpan(text: '\t${Constants.TEXT_BULLET}\t'),
                    TextSpan(text: (syncedItem.itemCompleteCount ?? 0) == 1
                        ? '1 Item'
                        : '${(syncedItem.itemCompleteCount ?? 0)} Items',
                    ),
                    TextSpan(text: '\t${Constants.TEXT_BULLET}\t'),
                    TextSpan(text: (syncedItem.totalSize ?? 0).lsBytes_BytesToString(decimals: 1)),
                    TextSpan(text: '\n'),
                    TextSpan(text: syncedItem.user ?? 'Unknown User'),
                    TextSpan(text: '\n'),
                    TextSpan(text: syncedItem.platform ?? 'Unknown Platform'),
                    TextSpan(text: '\t${Constants.TEXT_BULLET}\t'),
                    TextSpan(text: syncedItem.deviceName ?? 'Unknown Device'),
                ],
            ),
        ),
        decoration: syncedItem.ratingKey != null
            ? LSCardBackground(
                uri: Provider.of<TautulliState>(context, listen: false).getImageURLFromRatingKey(
                    syncedItem.ratingKey,
                    width: MediaQuery.of(context).size.width.truncate(),
                ),
                headers: Provider.of<TautulliState>(context, listen: false).headers,
            )
            : null,
        onTap: () async => _onTap(context),
        padContent: true,
    );

    Future<void> _onTap(BuildContext context) async => TautulliMediaDetailsRouter.navigateTo(context, ratingKey: syncedItem.ratingKey, mediaType: TautulliMediaType.NULL.from(syncedItem.metadataType));
}
