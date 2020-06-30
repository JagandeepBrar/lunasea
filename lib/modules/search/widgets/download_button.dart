import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/search.dart';
import 'package:lunasea/modules/nzbget.dart';
import 'package:lunasea/modules/sabnzbd.dart';

class SearchDetailsDownloadButton extends StatelessWidget {
    final bool icon;
    final NewznabResultData data;

    SearchDetailsDownloadButton({
        @required this.data,
        this.icon = false,
    });

    @override
    Widget build(BuildContext context) => icon
        ? LSIconButton(
            icon: Icons.file_download,
            onPressed: () => _sendToClient(context),
        )
        : LSButtonSlim(
            text: 'Download',
            onTap: () => _sendToClient(context),
            margin: EdgeInsets.zero,
        );

    Future<void> _sendToClient(BuildContext context) async {
        List _values = await SearchDialogs.downloadResult(context);
        if(_values[0]) {
            switch(_values[1]) {
                case 'sabnzbd': _sendToSABnzbd(context, data); break;
                case 'nzbget': _sendToNZBGet(context, data); break;
                case 'filesystem': _downloadToFilesystem(context); break;
                default: Logger.warning('SearchDetailsDownloadButton', '_sendToClient', 'Unknown case: ${_values[1]}'); break;
            }
        }
    }

    Future<void> _sendToSABnzbd(BuildContext context, NewznabResultData result) async {
        SABnzbdAPI _api = SABnzbdAPI.from(Database.currentProfileObject);
        await _api.uploadURL(result.linkDownload)
        .then((_) => LSSnackBar(
            context: context,
            title: 'Sent NZB Data',
            message: 'Sent to SABnzbd',
            type: SNACKBAR_TYPE.success,
            showButton: true,
            buttonOnPressed: () async => await Navigator.of(context).pushNamedAndRemoveUntil('/sabnzbd', (Route<dynamic> route) => false),

        ))
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Send',
            message: Constants.CHECK_LOGS_MESSAGE,
            type: SNACKBAR_TYPE.failure,
        ));
    }

    Future<void> _sendToNZBGet(BuildContext context, NewznabResultData result) async {
        NZBGetAPI _api = NZBGetAPI.from(Database.currentProfileObject);
        await _api.uploadURL(result.linkDownload)
        .then((_) => LSSnackBar(
            context: context,
            title: 'Sent NZB Data',
            message: 'Sent to NZBGet',
            type: SNACKBAR_TYPE.success,
            showButton: true,
            buttonOnPressed: () async => await Navigator.of(context).pushNamedAndRemoveUntil('/nzbget', (Route<dynamic> route) => false),
        ))
        .catchError((_) => LSSnackBar(
            context: context,
            title: 'Failed to Send',
            message: Constants.CHECK_LOGS_MESSAGE,
            type: SNACKBAR_TYPE.failure,
        ));
    }

    Future<void> _downloadToFilesystem(BuildContext context) async {
        LSSnackBar(context: context, title: 'Downloading...', message: 'Downloading NZB to your device', type: SNACKBAR_TYPE.info);
        try {
            Response response = await Dio(
                BaseOptions(
                    headers: {
                        'user-agent': Constants.USER_AGENT,
                    },
                    followRedirects: true,
                    maxRedirects: 5,
                ),
            ).get(data.linkDownload);
            if(response.statusCode == 200) {
                await Filesystem.exportDownloadToFilesystem('${data.title}.nzb', response.data);
                LSSnackBar(context: context, title: 'Downloaded NZB', message: 'Downloaded NZB to your device', type: SNACKBAR_TYPE.success);
            } else {
                throw Error();
            }
        } catch (error) {
            Logger.error('SearchDetailsDownloadButton', '_downloadToFilesystem', 'Error downloading NZB', error, StackTrace.current);
            LSSnackBar(context: context, title: 'Failed to Download NZB', message: Constants.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure);
        }
    }
} 
