import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliSyncedItemTile extends StatelessWidget {
    final TautulliSyncedItem syncedItem;

    TautulliSyncedItemTile({
        Key key,
        @required this.syncedItem,
    }): super(key: key);

    @override
    Widget build(BuildContext context) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: syncedItem.syncTitle),
            subtitle: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: LunaUI.FONT_SIZE_SUBTITLE,  
                    ),
                    children: [
                        TextSpan(
                            text: (syncedItem.state ?? 'Unknown').lunaCapitalizeFirstLetters(),
                            style: TextStyle(
                                color: LunaColours.accent,
                                fontWeight: LunaUI.FONT_WEIGHT_BOLD,
                            ),
                        ),
                        TextSpan(text: '\t${LunaUI.TEXT_EMDASH}\t'),
                        TextSpan(text: (syncedItem.metadataType ?? 'Unknown').lunaCapitalizeFirstLetters()),
                        TextSpan(text: '\t${LunaUI.TEXT_BULLET}\t'),
                        TextSpan(text: (syncedItem.itemCompleteCount ?? 0) == 1
                            ? '1 Item'
                            : '${(syncedItem.itemCompleteCount ?? 0)} Items',
                        ),
                        TextSpan(text: '\t${LunaUI.TEXT_BULLET}\t'),
                        TextSpan(text: (syncedItem.totalSize ?? 0).lunaBytesToString(decimals: 1)),
                        TextSpan(text: '\n'),
                        TextSpan(text: syncedItem.user ?? 'Unknown User'),
                        TextSpan(text: '\n'),
                        TextSpan(text: syncedItem.platform ?? 'Unknown Platform'),
                        TextSpan(text: '\t${LunaUI.TEXT_BULLET}\t'),
                        TextSpan(text: syncedItem.deviceName ?? 'Unknown Device'),
                    ],
                ),
            ),
            decoration: syncedItem.ratingKey != null
                ? LunaCardDecoration(
                    uri: context.watch<TautulliState>().getImageURLFromRatingKey(
                        syncedItem.ratingKey,
                        width: MediaQuery.of(context).size.width.truncate(),
                    ),
                    headers: context.watch<TautulliState>().headers,
                )
                : null,
            onTap: () async => _onTap(context),
            contentPadding: true,
        );
    }

    Future<void> _onTap(BuildContext context) async => TautulliMediaDetailsRouter().navigateTo(context, ratingKey: syncedItem.ratingKey, mediaType: TautulliMediaType.NULL.from(syncedItem.metadataType));
}
