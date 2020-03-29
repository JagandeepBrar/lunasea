import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import '../../radarr.dart';

class RadarrDetailsSearchTile extends StatelessWidget {
    final RadarrReleaseData data;
    
    RadarrDetailsSearchTile({
        @required this.data,
    });

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: data.title),
        subtitle: RichText(
            text: TextSpan(
                style: TextStyle(color: Colors.white70),
                children: [
                    TextSpan(
                        style: TextStyle(
                            color: data.isTorrent
                                ? LSColors.orange
                                : LSColors.accent,
                            fontWeight: FontWeight.bold,
                        ),
                        text: data.protocol.lsLanguage_Capitalize(),
                    ),
                    if(data.isTorrent) TextSpan(
                        text: '(${data.seeders}/${data.leechers})',
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    TextSpan(text: '\t•\t${data.ageHours.lsTime_releaseAgeString() ?? 'Unknown'}\n'),
                    TextSpan(text: '${data.quality ?? 'Unknown'}\t•\t'),
                    TextSpan(text: '${data.size.lsBytes_BytesToString() ?? 'Unknown'}'),
                ],
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
        onTap: () async => _enter(context),
        padContent: true,
    );

    Future<void> _enter(BuildContext context) async => await Navigator.of(context).pushNamed(
        RadarrDetailsSearchResults.ROUTE_NAME,
        arguments: RadarrDetailsSearchResultsArguments(data: data),
    );

    Future<void> _trailingOnPressed(BuildContext context) async {
        if(data.approved) {
            await _startDownload()
            .then((_) => LSSnackBar(context: context, title: 'Downloading...', message: data.title, type: SNACKBAR_TYPE.success))   
            .catchError((_) => LSSnackBar(context: context, title: 'Failed to Start Downloading', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
        } else {
            _showWarnings(context);
        }
    }

    Future<void> _trailingLongPressed(BuildContext context) async {
        if(!data.approved) {
            List<dynamic> values = await LSDialogRadarr.showDownloadWarningPrompt(context);
            if(values[0]) await _startDownload()
            .then((_) => LSSnackBar(context: context, title: 'Downloading...', message: data.title, type: SNACKBAR_TYPE.success))   
            .catchError((_) => LSSnackBar(context: context, title: 'Failed to Start Downloading', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure));
        }
    }

    Future<bool> _startDownload() async {
        RadarrAPI _api = RadarrAPI.from(Database.currentProfileObject);
        return await _api.downloadRelease(data.guid, data.indexerId);
    }

    Future<void> _showWarnings(BuildContext context) async {
        String reject = '';
        for(var i=0; i<data.rejections.length; i++) {
            reject += '${i+1}. ${data.rejections[i]}\n';
        }
        await LSDialogSystem.textPreview(context, 'Rejection Reasons', reject.substring(0, reject.length-1));
    }
}