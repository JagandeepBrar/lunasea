import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrManualImportParentDirectoryTile extends StatefulWidget {
  final RadarrFileSystem? fileSystem;

  const RadarrManualImportParentDirectoryTile({
    Key? key,
    required this.fileSystem,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrManualImportParentDirectoryTile> {
  LunaLoadingState _loadingState = LunaLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    if (widget.fileSystem == null ||
        widget.fileSystem!.parent == null ||
        widget.fileSystem!.parent!.isEmpty) return const SizedBox(height: 0.0);
    return LunaBlock(
      title: LunaUI.TEXT_ELLIPSIS,
      body: [TextSpan(text: 'radarr.ParentDirectory'.tr())],
      trailing: LunaIconButton(
        icon: Icons.arrow_upward_rounded,
        loadingState: _loadingState,
      ),
      onTap: () async {
        if (_loadingState == LunaLoadingState.INACTIVE) {
          if (mounted) setState(() => _loadingState = LunaLoadingState.ACTIVE);
          context.read<RadarrManualImportState>().fetchDirectories(
                context,
                widget.fileSystem!.parent,
              );
        }
      },
    );
  }
}
