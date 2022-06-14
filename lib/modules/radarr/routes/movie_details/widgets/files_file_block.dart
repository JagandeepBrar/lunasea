import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsFilesFileBlock extends StatefulWidget {
  final RadarrMovieFile file;

  const RadarrMovieDetailsFilesFileBlock({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMovieDetailsFilesFileBlock> {
  LunaLoadingState _deleteFileState = LunaLoadingState.INACTIVE;

  @override
  Widget build(BuildContext context) {
    return LunaTableCard(
      content: [
        LunaTableContent(
          title: 'relative path',
          body: widget.file.lunaRelativePath,
        ),
        LunaTableContent(
          title: 'video',
          body: widget.file.mediaInfo?.lunaVideoCodec,
        ),
        LunaTableContent(
          title: 'audio',
          body: [
            widget.file.mediaInfo?.lunaAudioCodec,
            if (widget.file.mediaInfo?.audioChannels != null)
              widget.file.mediaInfo?.audioChannels.toString(),
          ].join(LunaUI.TEXT_BULLET.pad()),
        ),
        LunaTableContent(
          title: 'size',
          body: widget.file.lunaSize,
        ),
        LunaTableContent(
          title: 'languages',
          body: widget.file.lunaLanguage,
        ),
        LunaTableContent(
          title: 'quality',
          body: widget.file.lunaQuality,
        ),
        LunaTableContent(
          title: 'formats',
          body: widget.file.lunaCustomFormats,
        ),
        LunaTableContent(
          title: 'added on',
          body: widget.file.lunaDateAdded,
        ),
      ],
      buttons: [
        if (widget.file.mediaInfo != null)
          LunaButton.text(
            text: 'Media Info',
            icon: Icons.info_outline_rounded,
            onTap: () async => _viewMediaInfo(),
          ),
        LunaButton(
          type: LunaButtonType.TEXT,
          text: 'Delete',
          icon: Icons.delete_rounded,
          onTap: () async => _deleteFile(),
          color: LunaColours.red,
          loadingState: _deleteFileState,
        ),
      ],
    );
  }

  Future<void> _deleteFile() async {
    setState(() => _deleteFileState = LunaLoadingState.ACTIVE);
    bool result = await RadarrDialogs().deleteMovieFile(context);
    if (result) {
      bool execute = await RadarrAPIHelper()
          .deleteMovieFile(context: context, movieFile: widget.file);
      if (execute) context.read<RadarrMovieDetailsState>().fetchFiles(context);
    }
    setState(() => _deleteFileState = LunaLoadingState.INACTIVE);
  }

  Future<void> _viewMediaInfo() async {
    LunaBottomModalSheet().show(
      builder: (context) => LunaListViewModal(
        children: [
          LunaHeader(text: 'radarr.Video'.tr()),
          LunaTableCard(
            content: [
              LunaTableContent(
                title: 'radarr.BitDepth'.tr(),
                body: widget.file.mediaInfo?.lunaVideoBitDepth,
              ),
              LunaTableContent(
                title: 'radarr.Codec'.tr(),
                body: widget.file.mediaInfo?.lunaVideoCodec,
              ),
              LunaTableContent(
                title: 'radarr.DynamicRange'.tr(),
                body: widget.file.mediaInfo?.lunaVideoDynamicRange,
              ),
              LunaTableContent(
                title: 'radarr.FPS'.tr(),
                body: widget.file.mediaInfo?.lunaVideoFps,
              ),
              LunaTableContent(
                title: 'radarr.Resolution'.tr(),
                body: widget.file.mediaInfo?.lunaVideoResolution,
              ),
            ],
          ),
          LunaHeader(text: 'radarr.Audio'.tr()),
          LunaTableCard(
            content: [
              LunaTableContent(
                title: 'radarr.Channels'.tr(),
                body: widget.file.mediaInfo?.lunaAudioChannels,
              ),
              LunaTableContent(
                title: 'radarr.Codec'.tr(),
                body: widget.file.mediaInfo?.lunaAudioCodec,
              ),
              LunaTableContent(
                title: 'radarr.Languages'.tr(),
                body: widget.file.mediaInfo?.lunaAudioLanguages,
              ),
              LunaTableContent(
                title: 'radarr.Streams'.tr(),
                body: widget.file.mediaInfo?.lunaAudioStreamCount,
              ),
            ],
          ),
          LunaHeader(text: 'radarr.Other'.tr()),
          LunaTableCard(
            content: [
              LunaTableContent(
                title: 'radarr.Runtime'.tr(),
                body: widget.file.mediaInfo?.lunaRunTime,
              ),
              LunaTableContent(
                title: 'radarr.ScanType'.tr(),
                body: widget.file.mediaInfo?.lunaScanType,
              ),
              LunaTableContent(
                title: 'radarr.Subtitles'.tr(),
                body: widget.file.mediaInfo?.lunaSubtitles,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
