import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrManualImportDirectoryTile extends StatefulWidget {
  final RadarrFileSystemDirectory directory;

  const RadarrManualImportDirectoryTile({
    Key? key,
    required this.directory,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrManualImportDirectoryTile> {
  LunaLoadingState _loadingState = LunaLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    RadarrFileSystemDirectory _dir = widget.directory;
    if (_dir.path?.isEmpty ?? true) return const SizedBox(height: 0.0);
    return LunaBlock(
      title: _dir.name ?? LunaUI.TEXT_EMDASH,
      body: [TextSpan(text: _dir.path)],
      trailing: LunaIconButton.arrow(loadingState: _loadingState),
      onTap: () async {
        if (_loadingState == LunaLoadingState.INACTIVE) {
          if (mounted) setState(() => _loadingState = LunaLoadingState.ACTIVE);
          context.read<RadarrManualImportState>().fetchDirectories(
                context,
                _dir.path,
              );
        }
      },
    );
  }
}
