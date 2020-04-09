import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../sonarr.dart';

class SonarrSearchResultTile extends StatelessWidget {
    final SonarrReleaseData data;

    SonarrSearchResultTile({
        @required this.data,
    });

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: data.title),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.0,
                ),
                children: <TextSpan>[
                    TextSpan(
                        text: data.protocol.lsLanguage_Capitalize(),
                        style: TextStyle(
                            color: data.isTorrent ? Colors.orange : Color(Constants.ACCENT_COLOR),
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    if(data.isTorrent) TextSpan(
                        text: '${data.isTorrent ? " (${data.seeders}/${data.leechers})" : ''}',
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    TextSpan(
                        text: '\t•\t${data.ageHours?.lsTime_releaseAgeString() ?? 'Unknown'}\n',
                    ),
                    TextSpan(
                        text: '${data.quality ?? 'Unknown'}\t•\t',
                    ),
                    TextSpan(
                        text: '${data.size?.lsBytes_BytesToString() ?? 'Unknown'}',
                    ),
                ]
            ),
        ),
        trailing: InkWell(
            child: LSIconButton(
                icon: data.approved
                    ? Icons.file_download
                    : Icons.report,
                color: data.approved
                    ? Colors.white
                    : LSColors.red,
                onPressed: () async => _trailingOnPressed(context),
            ),
            onLongPress: () async => _trailingLongPressed(context),
        ),
        padContent: true,
        onTap: () async => _enterDetails(context),
    );

    Future<void> _trailingOnPressed(BuildContext context) async {
        if(data.approved) {
            await _startDownload()
            .then((_) => LSSnackBar(
                context: context,
                title: 'Downloading...',
                message: data.title,
                type: SNACKBAR_TYPE.success,
                duration: Duration(seconds: 5),
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
        } else {
            _showWarnings(context);
        }
    }

    Future<void> _trailingLongPressed(BuildContext context) async {
        if(!data.approved) {
            List<dynamic> values = await LSDialogSonarr.showDownloadWarningPrompt(context);
            if(values[0]) await _startDownload()
            .then((_) => LSSnackBar(
                context: context,
                title: 'Downloading...',
                message: data.title,
                type: SNACKBAR_TYPE.success,
                duration: Duration(seconds: 5),
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

    Future<void> _showWarnings(BuildContext context) async {
        String reject = '';
        for(var i=0; i<data.rejections.length; i++) {
            reject += '${i+1}. ${data.rejections[i]}\n';
        }
        await LSDialogSystem.textPreview(context, 'Rejection Reasons', reject.substring(0, reject.length-1));
    }

    Future<bool> _startDownload() async {
        SonarrAPI _api = SonarrAPI.from(Database.currentProfileObject);
        return await _api.downloadRelease(data.guid, data.indexerId);
    }

    Future<void> _enterDetails(BuildContext context) async => Navigator.of(context).pushNamed(
        SonarrSearchDetails.ROUTE_NAME,
        arguments: SonarrSearchDetailsArguments(
            data: data,
        ),
    );
}
