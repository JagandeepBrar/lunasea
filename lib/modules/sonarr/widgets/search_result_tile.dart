import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSearchResultTile extends StatelessWidget {
    final SonarrReleaseData data;
    final ExpandableController _controller = ExpandableController();

    SonarrSearchResultTile({
        @required this.data,
    });

    @override
    Widget build(BuildContext context) => LSExpandable(
        controller: _controller,
        collapsed: _collapsed(context),
        expanded: _expanded(context),
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
                                    LSTitle(text: data.title, softWrap: true, maxLines: 12),
                                    Padding(
                                        child: Wrap(
                                            direction: Axis.horizontal,
                                            runSpacing: 10.0,
                                            children: [
                                                LSTextHighlighted(
                                                text: data.protocol.lsLanguage_Capitalize(),
                                                bgColor: data.isTorrent
                                                    ? LSColors.purple
                                                    : LSColors.blue,
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
                                                    if(data.isTorrent) TextSpan(
                                                        text: '${data.seeders} Seeders\t•\t${data.leechers} Leechers\n',
                                                        style: TextStyle(
                                                            color: LSColors.purple,
                                                            fontWeight: FontWeight.bold,
                                                        ),
                                                    ),
                                                    TextSpan(text: '${data.quality ?? 'Unknown'}\t•\t'),
                                                    TextSpan(text: '${data.size.lsBytes_BytesToString() ?? 'Unknown'}\t•\t'),
                                                    TextSpan(text: '${data.indexer}\n'),
                                                    TextSpan(text: '${data.ageHours.lsTime_releaseAgeString() ?? 'Unknown'}'),
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
                                                        margin: data.approved
                                                            ? EdgeInsets.zero
                                                            : EdgeInsets.only(right: 6.0),
                                                    ),
                                                ),
                                                if(!data.approved) Expanded(
                                                    child: LSButtonSlim(
                                                        text: 'Rejected',
                                                        backgroundColor: LSColors.red,
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

    Widget _collapsed(BuildContext context) => LSCardTile(
        title: LSTitle(text: data.title),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                ),
                children: <TextSpan>[
                    TextSpan(
                        style: TextStyle(
                            color: data.isTorrent
                                ? LSColors.purple
                                : LSColors.blue,
                            fontWeight: FontWeight.bold,
                        ),
                        text: data.protocol.lsLanguage_Capitalize(),
                    ),
                    if(data.isTorrent) TextSpan(
                        text: ' (${data.seeders}/${data.leechers})',
                        style: TextStyle(
                            color: LSColors.purple,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    TextSpan(text: '\t•\t${data.ageHours.lsTime_releaseAgeString() ?? 'Unknown'}\n'),
                    TextSpan(text: '${data.quality ?? 'Unknown'}\t•\t'),
                    TextSpan(text: '${data.size.lsBytes_BytesToString() ?? 'Unknown'}'),
                ]
            ),
        ),
        trailing: LSIconButton(
            icon: data.approved
                ? Icons.file_download
                : Icons.report,
            color: data.approved
                ? Colors.white
                : LSColors.red,
            onPressed: () async => data.approved
                ? _startDownload(context)
                : _showWarnings(context),
        ),
        padContent: true,
        onTap: () => _controller.toggle(),
    );

    Future<void> _showWarnings(BuildContext context) async {
        String reject = '';
        for(var i=0; i<data.rejections.length; i++) {
            reject += '${i+1}. ${data.rejections[i]}\n';
        }
        await GlobalDialogs.textPreview(context, 'Rejection Reasons', reject.substring(0, reject.length-1));
    }

    Future<void> _startDownload(BuildContext context) async {
        SonarrAPI _api = SonarrAPI.from(Database.currentProfileObject);
        await _api.downloadRelease(data.guid, data.indexerId)
        .then((_) => LSSnackBar(
            context: context,
            title: 'Downloading...',
            message: data.title,
            type: SNACKBAR_TYPE.success,
            showButton: true,
            buttonText: 'Back',
            buttonOnPressed: () => Navigator.of(context).popUntil(ModalRoute.withName(Sonarr.ROUTE_NAME)),
        ))   
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Start Downloading',
            message: Constants.CHECK_LOGS_MESSAGE,
            type: SNACKBAR_TYPE.failure,
        ));
    }
}
