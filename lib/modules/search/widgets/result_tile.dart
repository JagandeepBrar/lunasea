import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/nzbget.dart';
import 'package:lunasea/modules/sabnzbd.dart';
import 'package:lunasea/modules/search.dart';

class SearchResultTile extends StatelessWidget {
    final NewznabResultData data;

    SearchResultTile({
        @required this.data,
    });

    @override
    Widget build(BuildContext context) {
        return LunaExpandableListTile(
            title: data.title,
            collapsedSubtitle1: _subtitle1(),
            collapsedSubtitle2: _subtitle2(),
            expandedTableContent: _tableContent(),
            collapsedTrailing: _trailing(context),
            expandedTableButtons: _tableButtons(context),
        );
    }

    TextSpan _subtitle1() {
        return TextSpan(
            children: [
                TextSpan(text: data.size?.lunaBytesToString() ?? LunaUI.TEXT_EMDASH),
                TextSpan(text: LunaUI.TEXT_BULLET.lunaPad()),
                TextSpan(text: data.category ?? LunaUI.TEXT_EMDASH),
            ]
        );
    }

    TextSpan _subtitle2() {
        return TextSpan(text: data.age ?? LunaUI.TEXT_EMDASH);
    }

    List<LunaTableContent> _tableContent() {
        return [
            if(data.age != null) LunaTableContent(title: 'age', body: data.age),
            if(data.size != null) LunaTableContent(title: 'size', body: data.size.lunaBytesToString()),
            if(data.category != null) LunaTableContent(title: 'category', body: data.category),
            if(SearchDatabaseValue.SHOW_LINKS.data && data.linkComments != null && data.linkDownload != null) LunaTableContent(title: '', body: ''),
            if(SearchDatabaseValue.SHOW_LINKS.data && data.linkComments != null) LunaTableContent(title: 'comments', body: data.linkComments, bodyIsUrl: true),
            if(SearchDatabaseValue.SHOW_LINKS.data && data.linkDownload != null) LunaTableContent(title: 'download', body: data.linkDownload, bodyIsUrl: true),
        ];
    }

    List<LunaButton> _tableButtons(BuildContext context) {
        return [
            LunaButton.slim(
                text: 'Download',
                onTap: () async => _sendToClient(context),
            ),
        ];
    }

    LunaIconButton _trailing(BuildContext context) {
        return LunaIconButton(
            icon: Icons.file_download,
            onPressed: () => _sendToClient(context),
        );
    }

    Future<void> _sendToClient(BuildContext context) async {
        List _values = await SearchDialogs.downloadResult(context);
        if(_values[0]) {
            switch(_values[1]) {
                case 'sabnzbd': _sendToSABnzbd(context, data); break;
                case 'nzbget': _sendToNZBGet(context, data); break;
                case 'filesystem': _downloadToFilesystem(context); break;
                default: LunaLogger().warning('SearchDetailsDownloadButton', '_sendToClient', 'Unknown case: ${_values[1]}'); break;
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
            message: LunaLogger.CHECK_LOGS_MESSAGE,
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
            message: LunaLogger.CHECK_LOGS_MESSAGE,
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
            await LunaFileSystem().exportStringToShareSheet('${data.title.replaceAll(RegExp(r'[^0-9a-zA-Z. -]+'), '')}.nzb', response.data);
        } catch (error) {
            LunaLogger().error('Error downloading NZB', error, StackTrace.current);
            LSSnackBar(context: context, title: 'Failed to Download NZB', message: LunaLogger.CHECK_LOGS_MESSAGE, type: SNACKBAR_TYPE.failure);
        }
    }
}