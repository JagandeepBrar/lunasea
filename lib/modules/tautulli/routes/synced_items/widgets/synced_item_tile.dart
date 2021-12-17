import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliSyncedItemTile extends StatelessWidget {
  final TautulliSyncedItem syncedItem;

  const TautulliSyncedItemTile({
    Key key,
    @required this.syncedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: syncedItem.syncTitle,
      body: [
        _subtitle1(),
        _subtitle2(),
        _subtitle3(),
      ],
      backgroundHeaders: context.watch<TautulliState>().headers,
      backgroundUrl: context.watch<TautulliState>().getImageURLFromRatingKey(
            syncedItem?.ratingKey,
            width: MediaQuery.of(context).size.width.truncate(),
          ),
      onTap: () async => _onTap(context),
    );
  }

  TextSpan _subtitle1() {
    int _count = syncedItem.itemCompleteCount ?? 0;
    int _size = syncedItem.totalSize ?? 0;
    String _type = syncedItem.metadataType ?? 'lunasea.Unknown'.tr();

    return TextSpan(
      children: [
        TextSpan(text: _type.lunaCapitalizeFirstLetters()),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        TextSpan(text: _count == 1 ? '1 Item' : '$_count Items'),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        TextSpan(text: _size.lunaBytesToString(decimals: 1)),
      ],
    );
  }

  TextSpan _subtitle2() {
    return TextSpan(
      children: [
        TextSpan(text: syncedItem.user ?? 'Unknown User'),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        TextSpan(text: syncedItem.deviceName ?? 'Unknown Device'),
        TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
        TextSpan(text: syncedItem.platform ?? 'Unknown Platform'),
      ],
    );
  }

  TextSpan _subtitle3() {
    String _state = syncedItem.state ?? 'lunasea.Unknown'.tr();
    return TextSpan(
      text: _state.lunaCapitalizeFirstLetters(),
      style: const TextStyle(
        color: LunaColours.accent,
        fontWeight: LunaUI.FONT_WEIGHT_BOLD,
      ),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    TautulliMediaDetailsRouter().navigateTo(
      context,
      ratingKey: syncedItem.ratingKey,
      mediaType: TautulliMediaType.NULL.from(syncedItem.metadataType),
    );
  }
}
