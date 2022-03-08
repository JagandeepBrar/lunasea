import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrDiskSpaceTile extends StatelessWidget {
  final RadarrDiskSpace diskSpace;

  const RadarrDiskSpaceTile({
    Key? key,
    required this.diskSpace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: diskSpace.lunaPath,
      body: [TextSpan(text: diskSpace.lunaSpace)],
      bottom: LunaLinearPercentIndicator(
        percent: diskSpace.lunaPercentage / 100,
        progressColor: diskSpace.lunaColor,
      ),
      bottomHeight: LunaLinearPercentIndicator.height,
      trailing: LunaIconButton(
        text: diskSpace.lunaPercentageString,
        textSize: LunaUI.FONT_SIZE_H4,
        color: diskSpace.lunaColor,
      ),
    );
  }
}
