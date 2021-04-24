import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrManualImportDirectoryTile extends StatefulWidget {
  final RadarrFileSystemDirectory directory;

  RadarrManualImportDirectoryTile({
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
        widget.directory.path.isEmpty) return SizedBox(height: 0.0);
    return LunaListTile(
        context: context,
        title:
            LunaText.title(text: widget.directory?.name ?? LunaUI.TEXT_EMDASH),
        subtitle: LunaText.subtitle(
          text: widget.directory.path,
        ),
        trailing: LunaIconButton(
          icon: Icons.arrow_forward_ios_rounded,
          loadingState: _loadingState,
        ),
        onTap: () async {
          if (_loadingState == LunaLoadingState.INACTIVE) {
            if (mounted)
              setState(() => _loadingState = LunaLoadingState.ACTIVE);
            context.read<RadarrManualImportState>().fetchDirectories(
                  context,
                  widget.directory.path,
                );
          }
        });
  }
}
