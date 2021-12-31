import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrAddSearchResultTile extends StatelessWidget {
  final bool alreadyAdded;
  final LidarrSearchData data;

  const LidarrAddSearchResultTile({
    Key? key,
    required this.alreadyAdded,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => LunaBlock(
        title: data.title,
        disabled: alreadyAdded,
        body: [
          LunaTextSpan.extended(text: data.overview!.trim()),
        ],
        customBodyMaxLines: 3,
        trailing: alreadyAdded ? null : const LunaIconButton.arrow(),
        posterIsSquare: true,
        posterHeaders: Database.currentProfileObject!.getLidarr()['headers'],
        posterPlaceholderIcon: LunaIcons.USER,
        posterUrl: _posterUrl,
        onTap: () async => _enterDetails(context),
        onLongPress: () async {
          if (data.discogsLink == null || data.discogsLink == '')
            showLunaInfoSnackBar(
              title: 'No Discogs Page Available',
              message: 'No Discogs URL is available',
            );
          data.discogsLink!.lunaOpenGenericLink();
        },
      );

  String? get _posterUrl {
    Map<String, dynamic> image = data.images.firstWhere(
      (e) => e['coverType'] == 'poster',
      orElse: () => <String, dynamic>{},
    );
    return image['url'];
  }

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
