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
        return LSTableBlock(
            children: [
                LSTableContent(title: 'relative path', body: widget.movieFile?.lunaRelativePath),
                LSTableContent(title: 'size', body: widget.movieFile?.lunaSize),
                LSTableContent(title: 'quality', body: widget.movieFile?.lunaQuality),
                LSTableContent(title: 'added on', body: widget.movieFile?.lunaDateAdded),
                LSTableContent(title: 'custom formats', body: widget.movieFile?.lunaCustomFormats),
                LunaButtonContainer(
                    children: [
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
                ),
            ],
        );
    }

    Future<void> _deleteFile() async {
        setState(() => _deleteFileState = LunaLoadingState.ACTIVE);
        List values = await RadarrDialogs().deleteMovieFile(context);
        if(values[0]) {
            bool result = await RadarrAPIHelper().deleteMovieFile(context: context, movieFile: widget.movieFile);
            if(result) context.read<RadarrMovieDetailsState>().fetchFiles(context);
        }
        setState(() => _deleteFileState = LunaLoadingState.INACTIVE);
    }

    Future<void> _viewMediaInfo() async {
        LunaBottomModalSheet().showModal(
            context: context,
            builder: (context) => LSListView(
                children: [
                    LSHeader(text: 'Audio'),
                    LSTableBlock(
                        children: [
                            LSTableContent(title: 'bitrate', body: [
                                widget.movieFile.mediaInfo.audioBitrate?.lunaBytesToString(bytes: false) ?? Constants.TEXT_EMDASH,
                                if(widget.movieFile.mediaInfo.audioBitrate != null) '/s',
                            ].join()),
                            LSTableContent(title: 'channels', body: widget.movieFile.mediaInfo.audioChannels?.toString() ?? Constants.TEXT_EMDASH),
                            LSTableContent(title: 'codec', body: widget.movieFile.mediaInfo.audioCodec ?? Constants.TEXT_EMDASH),
                            LSTableContent(title: 'features', body: widget.movieFile.mediaInfo.audioAdditionalFeatures ?? Constants.TEXT_EMDASH),
                            LSTableContent(title: 'languages', body: widget.movieFile.mediaInfo.audioLanguages ?? Constants.TEXT_EMDASH),
                            LSTableContent(title: 'streams', body: widget.movieFile.mediaInfo.audioStreamCount?.toString() ?? Constants.TEXT_EMDASH),
                        ],
                    ),
                    LSHeader(text: 'Video'),
                    LSTableBlock(
                        children: [
                            LSTableContent(title: 'bit depth', body: widget.movieFile.mediaInfo.videoBitDepth?.toString() ?? Constants.TEXT_EMDASH),
                            LSTableContent(title: 'bitrate', body: [
                                widget.movieFile.mediaInfo.videoBitrate?.lunaBytesToString(bytes: false) ?? Constants.TEXT_EMDASH,
                                if(widget.movieFile.mediaInfo.videoBitrate != null) '/s',
                            ].join()),
                            LSTableContent(title: 'codec', body: widget.movieFile.mediaInfo.videoCodec ?? Constants.TEXT_EMDASH),
                            LSTableContent(title: 'fps', body: widget.movieFile.mediaInfo.videoFps?.toString() ?? Constants.TEXT_EMDASH),
                            LSTableContent(title: 'resolution', body: widget.movieFile.mediaInfo.resolution ?? Constants.TEXT_EMDASH),
                        ],
                    ),
                    LSHeader(text: 'Other'),
                    LSTableBlock(
                        children: [
                            LSTableContent(title: 'runtime', body: widget.movieFile.mediaInfo.runTime ?? Constants.TEXT_EMDASH),
                            LSTableContent(title: 'subtitles', body: widget.movieFile.mediaInfo.subtitles ?? Constants.TEXT_EMDASH),
                        ],
                    ),
                ]
            ),
        );
    }
}
