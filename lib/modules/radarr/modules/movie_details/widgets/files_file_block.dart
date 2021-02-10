import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrMovieDetailsFilesFileBlock extends StatelessWidget {
    final RadarrMovieFile movieFile;

    RadarrMovieDetailsFilesFileBlock({
        Key key,
        @required this.movieFile,
    }): super(key: key);

    @override
    Widget build(BuildContext context) => LSTableBlock(
        children: [
            LSTableContent(title: 'relative path', body: movieFile?.lunaRelativePath),
            LSTableContent(title: 'size', body: movieFile?.lunaSize),
            LSTableContent(title: 'quality', body: movieFile?.lunaQuality),
            LSTableContent(title: 'added on', body: movieFile?.lunaDateAdded),
            LSTableContent(title: 'custom formats', body: movieFile?.lunaCustomFormats),
            LunaButtonContainer(
                children: [
                    if(movieFile?.mediaInfo != null) LunaButton.slim(
                        text: 'Media Info',
                        onTap: () async => _viewMediaInfo(context),
                    ),
                    LunaButton.slim(
                        text: 'Delete',
                        onTap: () async => _deleteFile(context),
                        backgroundColor: LunaColours.red,
                    ),
                ],
            ),
        ],
    );

    Future<void> _deleteFile(BuildContext context) async {
        // TODO
    }

    Future<void> _viewMediaInfo(BuildContext context) async {
        LunaBottomModalSheet().showModal(
            context: context,
            builder: (context) => LSListView(
                children: [
                    LSHeader(text: 'Audio'),
                    LSTableBlock(
                        children: [
                            LSTableContent(title: 'bitrate', body: [
                                movieFile.mediaInfo.audioBitrate?.lunaBytesToString(bytes: false) ?? Constants.TEXT_EMDASH,
                                if(movieFile.mediaInfo.audioBitrate != null) '/s',
                            ].join()),
                            LSTableContent(title: 'channels', body: movieFile.mediaInfo.audioChannels?.toString() ?? Constants.TEXT_EMDASH),
                            LSTableContent(title: 'codec', body: movieFile.mediaInfo.audioCodec ?? Constants.TEXT_EMDASH),
                            LSTableContent(title: 'features', body: movieFile.mediaInfo.audioAdditionalFeatures ?? Constants.TEXT_EMDASH),
                            LSTableContent(title: 'languages', body: movieFile.mediaInfo.audioLanguages ?? Constants.TEXT_EMDASH),
                            LSTableContent(title: 'streams', body: movieFile.mediaInfo.audioStreamCount?.toString() ?? Constants.TEXT_EMDASH),
                        ],
                    ),
                    LSHeader(text: 'Video'),
                    LSTableBlock(
                        children: [
                            LSTableContent(title: 'bit depth', body: movieFile.mediaInfo.videoBitDepth?.toString() ?? Constants.TEXT_EMDASH),
                            LSTableContent(title: 'bitrate', body: [
                                movieFile.mediaInfo.videoBitrate?.lunaBytesToString(bytes: false) ?? Constants.TEXT_EMDASH,
                                if(movieFile.mediaInfo.videoBitrate != null) '/s',
                            ].join()),
                            LSTableContent(title: 'codec', body: movieFile.mediaInfo.videoCodec ?? Constants.TEXT_EMDASH),
                            LSTableContent(title: 'fps', body: movieFile.mediaInfo.videoFps?.toString() ?? Constants.TEXT_EMDASH),
                            LSTableContent(title: 'resolution', body: movieFile.mediaInfo.resolution ?? Constants.TEXT_EMDASH),
                        ],
                    ),
                    LSHeader(text: 'Other'),
                    LSTableBlock(
                        children: [
                            LSTableContent(title: 'runtime', body: movieFile.mediaInfo.runTime ?? Constants.TEXT_EMDASH),
                            LSTableContent(title: 'subtitles', body: movieFile.mediaInfo.subtitles ?? Constants.TEXT_EMDASH),
                        ],
                    ),
                ]
            ),
        );
    }
}
