import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrBookDetailsFilesFileBlock extends StatefulWidget {
  final ReadarrBookFile file;

  const ReadarrBookDetailsFilesFileBlock({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ReadarrBookDetailsFilesFileBlock> {
  LunaLoadingState _deleteFileState = LunaLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    return LunaTableCard(
      content: [
        LunaTableContent(
          title: 'path',
          body: widget.file.path,
        ),
        LunaTableContent(
          title: 'size',
          body: widget.file.lunaSize,
        ),
        LunaTableContent(
          title: 'quality',
          body: widget.file.lunaQuality,
        ),
        LunaTableContent(
          title: 'added on',
          body: widget.file.lunaDateAdded,
        ),
      ],
      buttons: [
/*        if (widget.file.mediaInfo != null)
          LunaButton.text(
            text: 'Media Info',
            icon: Icons.info_outline_rounded,
            onTap: () async => _viewMediaInfo(),
          ),*/
        LunaButton(
          type: LunaButtonType.TEXT,
          text: 'Delete',
          icon: Icons.delete_rounded,
          onTap: () async => _deleteBookFile(),
          color: LunaColours.red,
          loadingState: _deleteFileState,
        ),
      ],
    );
  }

  Future<void> _deleteBookFile() async {
    setState(() => _deleteFileState = LunaLoadingState.ACTIVE);
    bool result = await ReadarrDialogs().deleteBookFile(context);
    if (result) {
      bool execute = await ReadarrAPIController()
          .deleteBookFile(context: context, bookFile: widget.file);
      if (execute) context.read<ReadarrBookDetailsState>().fetchFiles(context);
    }
    setState(() => _deleteFileState = LunaLoadingState.INACTIVE);
  }

/*
  Future<void> _viewMediaInfo() async {
    LunaBottomModalSheet().show(
      context: context,
      builder: (context) => LunaListViewModal(
        children: [
          const LunaHeader(text: 'Video'),
          LunaTableCard(
            content: [
              LunaTableContent(
                title: 'bit depth',
                body: widget.file.mediaInfo?.lunaVideoBitDepth,
              ),
              LunaTableContent(
                title: 'bitrate',
                body: widget.file.mediaInfo?.lunaVideoBitrate,
              ),
              LunaTableContent(
                title: 'codec',
                body: widget.file.mediaInfo?.lunaVideoCodec,
              ),
              LunaTableContent(
                title: 'fps',
                body: widget.file.mediaInfo?.lunaVideoFps,
              ),
              LunaTableContent(
                title: 'resolution',
                body: widget.file.mediaInfo?.lunaVideoResolution,
              ),
            ],
          ),
          const LunaHeader(text: 'Audio'),
          LunaTableCard(
            content: [
              LunaTableContent(
                title: 'bitrate',
                body: widget.file.mediaInfo?.lunaAudioBitrate,
              ),
              LunaTableContent(
                title: 'channels',
                body: widget.file.mediaInfo?.lunaAudioChannels,
              ),
              LunaTableContent(
                title: 'codec',
                body: widget.file.mediaInfo?.lunaAudioCodec,
              ),
              LunaTableContent(
                title: 'features',
                body: widget.file.mediaInfo?.lunaAudioAdditionalFeatures,
              ),
              LunaTableContent(
                title: 'languages',
                body: widget.file.mediaInfo?.lunaAudioLanguages,
              ),
              LunaTableContent(
                title: 'streams',
                body: widget.file.mediaInfo?.lunaAudioStreamCount,
              ),
            ],
          ),
          const LunaHeader(text: 'Other'),
          LunaTableCard(
            content: [
              LunaTableContent(
                title: 'runtime',
                body: widget.file.mediaInfo?.lunaRunTime,
              ),
              LunaTableContent(
                title: 'subtitles',
                body: widget.file.mediaInfo?.lunaSubtitles,
              ),
            ],
          ),
        ],
      ),
    );
  }*/
}
