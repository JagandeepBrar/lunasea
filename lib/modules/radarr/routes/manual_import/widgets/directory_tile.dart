import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrManualImportDirectoryTile extends StatefulWidget {
  final RadarrFileSystemDirectory directory;

  const RadarrManualImportDirectoryTile({
    Key key,
    @required this.directory,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrManualImportDirectoryTile> {
  LunaLoadingState _loadingState = LunaLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    if (widget.directory == null ||
        widget.directory.path == null ||
        widget.directory.path.isEmpty) return const SizedBox(height: 0.0);
    return LunaBlock(
      title: widget.directory?.name ?? LunaUI.TEXT_EMDASH,
      body: [TextSpan(text: widget.directory.path)],
      trailing: LunaIconButton.arrow(loadingState: _loadingState),
      onTap: () async {
        if (_loadingState == LunaLoadingState.INACTIVE) {
          if (mounted) setState(() => _loadingState = LunaLoadingState.ACTIVE);
          context.read<RadarrManualImportState>().fetchDirectories(
                context,
                widget.directory.path,
              );
        }
      },
    );
  }
}
