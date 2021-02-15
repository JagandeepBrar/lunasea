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
                LunaTableContent(title: 'size', body: widget.movieFile?.lunaSize),
                LunaTableContent(title: 'quality', body: widget.movieFile?.lunaQuality),
                LunaTableContent(title: 'added on', body: widget.movieFile?.lunaDateAdded),
                LunaTableContent(title: 'custom formats', body: widget.movieFile?.lunaCustomFormats),
            ],
            buttons: [
                if(widget.movieFile?.mediaInfo != null) LunaButton.slim(
                    text: 'Media Info',
                    onTap: () async => _viewMediaInfo(),
                ),
                LunaButton.slim(
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
                    LunaHeader(text: 'Audio'),
                    LunaTableCard(
                        content: [
                            LunaTableContent(title: 'bitrate', body: [
                                widget.movieFile.mediaInfo.audioBitrate?.lunaBytesToString(bytes: false) ?? Constants.TEXT_EMDASH,
                                if(widget.movieFile.mediaInfo.audioBitrate != null) '/s',
                            ].join()),
                            LunaTableContent(title: 'channels', body: widget.movieFile.mediaInfo.audioChannels?.toString() ?? Constants.TEXT_EMDASH),
                            LunaTableContent(title: 'codec', body: widget.movieFile.mediaInfo.audioCodec ?? Constants.TEXT_EMDASH),
                            LunaTableContent(title: 'features', body: widget.movieFile.mediaInfo.audioAdditionalFeatures ?? Constants.TEXT_EMDASH),
                            LunaTableContent(title: 'languages', body: widget.movieFile.mediaInfo.audioLanguages ?? Constants.TEXT_EMDASH),
                            LunaTableContent(title: 'streams', body: widget.movieFile.mediaInfo.audioStreamCount?.toString() ?? Constants.TEXT_EMDASH),
                        ],
                    ),
                    LunaHeader(text: 'Video'),
                    LunaTableCard(
                        content: [
                            LunaTableContent(title: 'bit depth', body: widget.movieFile.mediaInfo.videoBitDepth?.toString() ?? Constants.TEXT_EMDASH),
                            LunaTableContent(title: 'bitrate', body: [
                                widget.movieFile.mediaInfo.videoBitrate?.lunaBytesToString(bytes: false) ?? Constants.TEXT_EMDASH,
                                if(widget.movieFile.mediaInfo.videoBitrate != null) '/s',
                            ].join()),
                            LunaTableContent(title: 'codec', body: widget.movieFile.mediaInfo.videoCodec ?? Constants.TEXT_EMDASH),
                            LunaTableContent(title: 'fps', body: widget.movieFile.mediaInfo.videoFps?.toString() ?? Constants.TEXT_EMDASH),
                            LunaTableContent(title: 'resolution', body: widget.movieFile.mediaInfo.resolution ?? Constants.TEXT_EMDASH),
                        ],
                    ),
                    LunaHeader(text: 'Other'),
                    LunaTableCard(
                        content: [
                            LunaTableContent(title: 'runtime', body: widget.movieFile.mediaInfo.runTime ?? Constants.TEXT_EMDASH),
                            LunaTableContent(title: 'subtitles', body: widget.movieFile.mediaInfo.subtitles ?? Constants.TEXT_EMDASH),
                        ],
                    ),
                ]
            ),
        );
    }
}
