import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrAddSearchResultTile extends StatelessWidget {
  final bool alreadyAdded;
  final LidarrSearchData data;

  const LidarrAddSearchResultTile({
    Key key,
    @required this.alreadyAdded,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => LunaBlock(
        title: data.title,
        disabled: alreadyAdded,
        body: [
          LunaTextSpan.extended(text: data.overview.trim()),
        ],
        customBodyMaxLines: 2,
        trailing: alreadyAdded ? null : const LunaIconButton.arrow(),
        onTap: () async => _enterDetails(context),
      );

  Future<void> _enterDetails(BuildContext context) async {
    if (alreadyAdded) {
      showLunaInfoSnackBar(
        title: 'Artist Already in Lidarr',
        message: data.title,
      );
    } else {
      final dynamic result = await Navigator.of(context).pushNamed(
        LidarrAddDetails.ROUTE_NAME,
        arguments: LidarrAddDetailsArguments(data: data),
      );
      if (result != null) {
        switch (result[0]) {
          case 'artist_added':
            Navigator.of(context).pop(result);
            break;
          default:
            LunaLogger().warning(
              'LidarrAddSearchResultTile',
              '_enterDetails',
              'Unknown Case: ${result[0]}',
            );
            break;
        }
      }
    }
  }
}
