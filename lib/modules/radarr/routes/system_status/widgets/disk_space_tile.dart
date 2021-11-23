import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class RadarrDiskSpaceTile extends StatelessWidget {
  final RadarrDiskSpace diskSpace;
  final RadarrRootFolder rootFolder;

  RadarrDiskSpaceTile({
    Key key,
    this.diskSpace,
    this.rootFolder,
  }) : super(key: key) {
    if (diskSpace == null)
      assert(
          rootFolder != null, 'diskSpace and rootFolder cannot both be null');
    if (rootFolder == null)
      assert(diskSpace != null, 'diskSpace and rootFolder cannot both be null');
  }

  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: diskSpace?.lunaPath ?? rootFolder?.lunaPath),
      subtitle: Stack(
        children: [
          LunaText.subtitle(
            text: diskSpace?.lunaSpace ?? rootFolder?.lunaSpace,
            maxLines: 2,
          ),
          if (diskSpace != null) percentBar(),
        ],
      ),
      trailing: LunaIconButton(
        text: diskSpace?.lunaPercentageString ??
            (rootFolder?.unmappedFolders?.length ?? 0).toString(),
        color: diskSpace?.lunaColor ?? LunaColours.accent,
      ),
      contentPadding: diskSpace != null,
    );
  }

  Widget percentBar() {
    return LinearPercentIndicator(
      percent: (diskSpace.lunaPercentage ?? 0) / 100,
      padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 26.0),
      progressColor: diskSpace.lunaColor,
      backgroundColor: diskSpace.lunaColor.withOpacity(0.30),
      lineHeight: 4.0,
    );
  }
}
