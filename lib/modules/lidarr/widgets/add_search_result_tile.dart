import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/links.dart';
import 'package:lunasea/modules/lidarr.dart';
import 'package:lunasea/router/routes/lidarr.dart';

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
        posterHeaders: LunaProfile.current.lidarrHeaders,
        posterPlaceholderIcon: LunaIcons.USER,
        posterUrl: _posterUrl,
        onTap: () async => _enterDetails(context),
        onLongPress: () async {
          if (data.discogsLink == null || data.discogsLink == '')
            showLunaInfoSnackBar(
              title: 'No Discogs Page Available',
              message: 'No Discogs URL is available',
            );
          data.discogsLink!.openLink();
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
      LidarrRoutes.ADD_ARTIST_DETAILS.go(extra: data);
    }
  }
}
