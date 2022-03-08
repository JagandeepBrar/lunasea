import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrRootFolderTile extends StatelessWidget {
  final RadarrRootFolder rootFolder;

  const RadarrRootFolderTile({
    Key? key,
    required this.rootFolder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: rootFolder.lunaPath,
      body: [
        TextSpan(text: rootFolder.lunaSpace),
        TextSpan(
          text: rootFolder.lunaUnmappedFolders,
          style: const TextStyle(
            color: LunaColours.accent,
            fontWeight: LunaUI.FONT_WEIGHT_BOLD,
          ),
        )
      ],
    );
  }
}
