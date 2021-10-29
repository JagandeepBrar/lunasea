import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrAddSearchResultTile extends StatelessWidget {
  final bool alreadyAdded;
  final LidarrSearchData data;

  const LidarrAddSearchResultTile({
    @required this.alreadyAdded,
    @required this.data,
  });

  @override
  Widget build(BuildContext context) => LunaListTile(
        context: context,
        title: LunaText.title(text: data.title, darken: alreadyAdded),
        subtitle: LunaText.subtitle(
          text: '${data.overview.trim()}\n\n',
          darken: alreadyAdded,
          maxLines: 2,
        ),
        contentPadding: true,
        trailing: alreadyAdded
            ? null
            : LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
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
