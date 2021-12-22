import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsFilesFileBlock extends StatefulWidget {
  final RadarrMovieFile movieFile;

  const RadarrMovieDetailsFilesFileBlock({
    Key key,
    @required this.movieFile,
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
          body: widget.movieFile.lunaRelativePath,
        ),
        LunaTableContent(
          title: 'video',
          body: widget.movieFile.mediaInfo?.lunaVideoCodec,
        ),
        LunaTableContent(
          title: 'audio',
          body: [
            widget.movieFile?.mediaInfo?.lunaAudioCodec,
            if (widget.movieFile?.mediaInfo?.audioChannels != null)
              widget.movieFile?.mediaInfo?.audioChannels.toString(),
          ].join(LunaUI.TEXT_BULLET.lunaPad()),
        ),
        LunaTableContent(
          title: 'size',
          body: widget.movieFile?.lunaSize,
        ),
        LunaTableContent(
          title: 'languages',
          body: widget.movieFile?.lunaLanguage,
        ),
        LunaTableContent(
          title: 'quality',
          body: widget.movieFile?.lunaQuality,
        ),
        LunaTableContent(
          title: 'formats',
          body: widget.movieFile?.lunaCustomFormats,
        ),
        LunaTableContent(
          title: 'added on',
          body: widget.movieFile?.lunaDateAdded,
        ),
      ],
      buttons: [
        if (widget.movieFile?.mediaInfo != null)
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
          .deleteMovieFile(context: context, movieFile: widget.movieFile);
      if (execute) context.read<RadarrMovieDetailsState>().fetchFiles(context);
    }
    setState(() => _deleteFileState = LunaLoadingState.INACTIVE);
  }

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
                body: widget.movieFile?.mediaInfo?.lunaVideoBitDepth,
              ),
              LunaTableContent(
                title: 'bitrate',
                body: widget.movieFile?.mediaInfo?.lunaVideoBitrate,
              ),
              LunaTableContent(
                title: 'codec',
                body: widget.movieFile?.mediaInfo?.lunaVideoCodec,
              ),
              LunaTableContent(
                title: 'fps',
                body: widget.movieFile?.mediaInfo?.lunaVideoFps,
              ),
              LunaTableContent(
                title: 'resolution',
                body: widget.movieFile?.mediaInfo?.lunaVideoResolution,
              ),
            ],
          ),
          const LunaHeader(text: 'Audio'),
          LunaTableCard(
            content: [
              LunaTableContent(
                title: 'bitrate',
                body: widget.movieFile?.mediaInfo?.lunaAudioBitrate,
              ),
              LunaTableContent(
                title: 'channels',
                body: widget.movieFile?.mediaInfo?.lunaAudioChannels,
              ),
              LunaTableContent(
                title: 'codec',
                body: widget.movieFile?.mediaInfo?.lunaAudioCodec,
              ),
              LunaTableContent(
                title: 'features',
                body: widget.movieFile?.mediaInfo?.lunaAudioAdditionalFeatures,
              ),
              LunaTableContent(
                title: 'languages',
                body: widget.movieFile?.mediaInfo?.lunaAudioLanguages,
              ),
              LunaTableContent(
                title: 'streams',
                body: widget.movieFile?.mediaInfo?.lunaAudioStreamCount,
              ),
            ],
          ),
          const LunaHeader(text: 'Other'),
          LunaTableCard(
            content: [
              LunaTableContent(
                title: 'runtime',
                body: widget.movieFile?.mediaInfo?.lunaRunTime,
              ),
              LunaTableContent(
                title: 'subtitles',
                body: widget.movieFile?.mediaInfo?.lunaSubtitles,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
