import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsFilesFileBlock extends StatefulWidget {
    final RadarrMovieFile movieFile;

    RadarrMovieDetailsFilesFileBlock({
        Key key,
        @required this.movieFile,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<RadarrMovieDetailsFilesFileBlock> {
    LunaLoadingState _deleteFileState = LunaLoadingState.INACTIVE;

    @override
    Widget build(BuildContext context) {
        return LunaTableCard(
            content: [
                LunaTableContent(title: 'relative path', body: widget.movieFile?.lunaRelativePath),
                LunaTableContent(title: 'video', body: widget.movieFile.mediaInfo.videoCodec ?? LunaUI.TEXT_EMDASH),
                LunaTableContent(
                    title: 'audio',
                    body: [
                        widget.movieFile.mediaInfo.audioCodec ?? LunaUI.TEXT_EMDASH,
                        if(widget.movieFile.mediaInfo.audioChannels != null) widget.movieFile.mediaInfo.audioChannels.toString(),
                    ].join(LunaUI.TEXT_EMDASH.lunaPad()),
                ),
                LunaTableContent(title: 'size', body: widget.movieFile?.lunaSize),
                LunaTableContent(title: 'languages', body: widget.movieFile?.lunaLanguage),
                LunaTableContent(title: 'quality', body: widget.movieFile?.lunaQuality),
                LunaTableContent(title: 'formats', body: widget.movieFile?.lunaCustomFormats),
                LunaTableContent(title: 'added on', body: widget.movieFile?.lunaDateAdded),
            ],
            buttons: [
                if(widget.movieFile?.mediaInfo != null) LunaButton.text(
                    text: 'Media Info',
                    onTap: () async => _viewMediaInfo(),
                ),
                LunaButton(
                    type: LunaButtonType.TEXT,
                    text: 'Delete',
                    onTap: () async => _deleteFile(),
                    backgroundColor: LunaColours.red,
                    loadingState: _deleteFileState,
                ),
            ],
        );
    }

    Future<void> _deleteFile() async {
        setState(() => _deleteFileState = LunaLoadingState.ACTIVE);
        bool result = await RadarrDialogs().deleteMovieFile(context);
        if(result) {
            bool execute = await RadarrAPIHelper().deleteMovieFile(context: context, movieFile: widget.movieFile);
            if(execute) context.read<RadarrMovieDetailsState>().fetchFiles(context);
        }
        setState(() => _deleteFileState = LunaLoadingState.INACTIVE);
    }

    Future<void> _viewMediaInfo() async {
        LunaBottomModalSheet().showModal(
            context: context,
            builder: (context) => LunaListViewModal(
                children: [
                    LunaHeader(text: 'Video'),
                    LunaTableCard(
                        content: [
                            LunaTableContent(title: 'bit depth', body: widget.movieFile.mediaInfo.videoBitDepth?.toString() ?? LunaUI.TEXT_EMDASH),
                            LunaTableContent(title: 'bitrate', body: [
                                widget.movieFile.mediaInfo.videoBitrate?.lunaBytesToString(bytes: false) ?? LunaUI.TEXT_EMDASH,
                                if(widget.movieFile.mediaInfo.videoBitrate != null) '/s',
                            ].join()),
                            LunaTableContent(title: 'codec', body: widget.movieFile.mediaInfo.videoCodec ?? LunaUI.TEXT_EMDASH),
                            LunaTableContent(title: 'fps', body: widget.movieFile.mediaInfo.videoFps?.toString() ?? LunaUI.TEXT_EMDASH),
                            LunaTableContent(title: 'resolution', body: widget.movieFile.mediaInfo.resolution ?? LunaUI.TEXT_EMDASH),
                        ],
                    ),
                    LunaHeader(text: 'Audio'),
                    LunaTableCard(
                        content: [
                            LunaTableContent(title: 'bitrate', body: [
                                widget.movieFile.mediaInfo.audioBitrate?.lunaBytesToString(bytes: false) ?? LunaUI.TEXT_EMDASH,
                                if(widget.movieFile.mediaInfo.audioBitrate != null) '/s',
                            ].join()),
                            LunaTableContent(title: 'channels', body: widget.movieFile.mediaInfo.audioChannels?.toString() ?? LunaUI.TEXT_EMDASH),
                            LunaTableContent(title: 'codec', body: widget.movieFile.mediaInfo.audioCodec ?? LunaUI.TEXT_EMDASH),
                            LunaTableContent(title: 'features', body: widget.movieFile.mediaInfo.audioAdditionalFeatures ?? LunaUI.TEXT_EMDASH),
                            LunaTableContent(title: 'languages', body: widget.movieFile.mediaInfo.audioLanguages ?? LunaUI.TEXT_EMDASH),
                            LunaTableContent(title: 'streams', body: widget.movieFile.mediaInfo.audioStreamCount?.toString() ?? LunaUI.TEXT_EMDASH),
                        ],
                    ),
                    LunaHeader(text: 'Other'),
                    LunaTableCard(
                        content: [
                            LunaTableContent(title: 'runtime', body: widget.movieFile.mediaInfo.runTime ?? LunaUI.TEXT_EMDASH),
                            LunaTableContent(title: 'subtitles', body: widget.movieFile.mediaInfo.subtitles ?? LunaUI.TEXT_EMDASH),
                        ],
                    ),
                ]
            ),
        );
    }
}
