import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

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
    return LunaBlock(
      title: diskSpace?.lunaPath ?? rootFolder?.lunaPath,
      body: [TextSpan(text: diskSpace?.lunaSpace ?? rootFolder?.lunaSpace)],
      bottom: diskSpace != null ? _bottomWidget() : null,
      bottomHeight: LunaLinearPercentIndicator.height,
      trailing: LunaIconButton(
        text: diskSpace?.lunaPercentageString ??
            (rootFolder?.unmappedFolders?.length ?? 0).toString(),
        textSize: LunaUI.FONT_SIZE_H4,
        color: diskSpace?.lunaColor ?? LunaColours.accent,
      ),
    );
  }

  Widget _bottomWidget() {
    return LunaLinearPercentIndicator(
      percent: (diskSpace.lunaPercentage ?? 0) / 100,
      progressColor: diskSpace.lunaColor ?? LunaColours.accent,
    );
  }
}
