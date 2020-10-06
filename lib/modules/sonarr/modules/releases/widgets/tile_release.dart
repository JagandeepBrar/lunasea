import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrReleasesReleaseTile extends StatelessWidget {
    final SonarrRelease release;
    final ExpandableController _controller = ExpandableController();

    SonarrReleasesReleaseTile({
        Key key,
        @required this.release,
    }): super(key: key);

    @override
    Widget build(BuildContext context) => LSExpandable(
        controller: _controller,
        collapsed: _collapsed(context),
        expanded: _expanded(context),
    );

    Widget _collapsed(BuildContext context) => LSCardTile(
        title: LSTitle(text: release.title),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                children: <TextSpan>[
                    TextSpan(
                        style: TextStyle(
                            color: release.protocol == 'torrent'
                                ? LunaColours.purple
                                : LunaColours.blue,
                            fontWeight: FontWeight.bold,
                        ),
                        text: release.protocol.lsLanguage_Capitalize(),
                    ),
                    if(release.protocol == 'torrent') TextSpan(
                        text: ' (${release.seeders}/${release.leechers})',
                        style: TextStyle(
                            color: LunaColours.purple,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    TextSpan(text: '\t•\t${release.indexer}\t•\t'),
                    TextSpan(text: '${release?.ageHours?.lsTime_releaseAgeString() ?? 'Unknown'}\n'),
                    TextSpan(text: '${release?.quality?.quality?.name ?? 'Unknown'}\t•\t'),
                    TextSpan(text: '${release?.size?.lsBytes_BytesToString() ?? 'Unknown'}'),
                ]
            ),
        ),
        trailing: LSIconButton(
            icon: release.approved
                ? Icons.file_download
                : Icons.report,
            color: release.approved
                ? Colors.white
                : LunaColours.red,
            onPressed: () async => release.approved
                ? _startDownload(context)
                : _showWarnings(context),
        ),
        padContent: true,
        onTap: () => _controller.toggle(),
    );

    Widget _expanded(BuildContext context) => LSCard(
        child: InkWell(
            child: Row(
                children: [
                    Expanded(
                        child: Padding(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    LSTitle(text: release.title, softWrap: true, maxLines: 12),
                                    Padding(
                                        child: Wrap(
                                            direction: Axis.horizontal,
                                            runSpacing: 10.0,
                                            children: [
                                                LSTextHighlighted(
                                                text: release.protocol.lsLanguage_Capitalize(),
                                                bgColor: release.protocol == 'torrent'
                                                    ? LunaColours.purple
                                                    : LunaColours.blue,
                                                ),
                                            ],
                                        ),
                                        padding: EdgeInsets.only(top: 8.0, bottom: 2.0),
                                    ),
                                    Padding(
                                        child: RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                                                ),
                                                children: [
                                                    if(release.protocol == 'torrent') TextSpan(
                                                        text: '${release.seeders} Seeders\t•\t${release.leechers} Leechers\n',
                                                        style: TextStyle(
                                                            color: LunaColours.purple,
                                                            fontWeight: FontWeight.bold,
                                                        ),
                                                    ),
                                                    TextSpan(text: '${release?.quality?.quality?.name ?? 'Unknown'}\t•\t'),
                                                    TextSpan(text: '${release?.size?.lsBytes_BytesToString() ?? 'Unknown'}\t•\t'),
                                                    TextSpan(text: '${release?.indexer}\n'),
                                                    TextSpan(text: '${release?.ageHours?.lsTime_releaseAgeString() ?? 'Unknown'}'),
                                                ],
                                            ),
                                        ),
                                        padding: EdgeInsets.only(top: 6.0, bottom: 10.0),
                                    ),
                                    Padding(
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                                Expanded(
                                                    child: LSButtonSlim(
                                                        text: 'Download',
                                                        onTap: () => _startDownload(context),
                                                        margin: release.approved
                                                            ? EdgeInsets.zero
                                                            : EdgeInsets.only(right: 6.0),
                                                    ),
                                                ),
                                                if(!release.approved) Expanded(
                                                    child: LSButtonSlim(
                                                        text: 'Rejected',
                                                        backgroundColor: LunaColours.red,
                                                        onTap: () => _showWarnings(context),
                                                        margin: EdgeInsets.only(left: 6.0),
                                                    ),
                                                ),
                                            ],
                                        ),
                                        padding: EdgeInsets.only(bottom: 2.0),
                                    ),
                                ],
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                        ),
                    )
                ],
            ),
            borderRadius: BorderRadius.circular(Constants.UI_BORDER_RADIUS),
            onTap: () => _controller.toggle(),
        ),
    );

    Future<void> _startDownload(BuildContext context) async {
        if(context.read<SonarrState>().api != null) context.read<SonarrState>().api.release.addRelease(
            guid: release.guid,
            indexerId: release.indexerId,
        )
        .then((_) => LSSnackBar(
            context: context,
            title: 'Downloading Release...',
            message: release.title,
            type: SNACKBAR_TYPE.success,
        ))
        .catchError((error, stack) {
            LunaLogger.error(
                'SonarrReleasesReleaseTile',
                '_startDownload',
                'Unable to download release: ${release.guid}',
                error,
                stack,
            );
            LSSnackBar(
                context: context,
                title: 'Failed to Download Release',
                type: SNACKBAR_TYPE.failure,
            );
        });
    }

    Future<void> _showWarnings(BuildContext context) async {
        String rejections = '';
        for(var i=0; i<release.rejections.length; i++) {
            rejections += '${i+1}. ${release.rejections[i]}\n';
        }
        await LunaDialogs.textPreview(context, 'Rejection Reasons', rejections.trim());
    }
}