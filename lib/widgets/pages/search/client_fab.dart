import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class SearchDetailsClientFAB extends StatelessWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;

    SearchDetailsClientFAB({
        @required this.scaffoldKey,
    });

    @override
    Widget build(BuildContext context) => LSFloatingActionButton(
        icon: Icons.cloud_download,
        onPressed: () => _sendToClient(context),
    );

    Future<void> _sendToClient(BuildContext context) async {
        List _values = await LSDialogSearch.sendToClient(context);
        if(_values[0]) {
            final _result = Provider.of<SearchModel>(context, listen: false).resultDetails;
            switch(_values[1]) {
                case 'sabnzbd': _sendToSABnzbd(context, _result); break;
                case 'nzbget': _sendToNZBGet(context, _result); break;
                case 'filesystem': _downloadToFilesystem(context); break;
                default: Logger.warning('LSSearchDetailsClientFAB', '_sendToClient', 'Unknown case: ${_values[1]}'); break;
            }
        }
    }

    Future<void> _sendToSABnzbd(BuildContext context, NewznabResultData result) async {
        Notifications.showSnackBar(scaffoldKey, 'Sending to SABnzbd...');
        SABnzbdAPI _api = SABnzbdAPI.from(Database.currentProfileObject);
        await _api.uploadURL(result.linkDownload)
            ? Notifications.showSnackBar(scaffoldKey, 'Sent to SABnzbd!')
            : Notifications.showSnackBar(scaffoldKey, 'Failed to send to SABnzbd');
    }

    Future<void> _sendToNZBGet(BuildContext context, NewznabResultData result) async {
        Notifications.showSnackBar(scaffoldKey, 'Sending to NZBGet...');
        NZBGetAPI _api = NZBGetAPI.from(Database.currentProfileObject);
        await _api.uploadURL(result.linkDownload)
            ? Notifications.showSnackBar(scaffoldKey, 'Sent to NZBGet!')
            : Notifications.showSnackBar(scaffoldKey, 'Failed to send to NZBGet');
    }

    Future<void> _downloadToFilesystem(BuildContext context) async {
        Notifications.showSnackBar(scaffoldKey, 'Downloading NZB...');
        try {
            final result = Provider.of<SearchModel>(context, listen: false).resultDetails;
            Response response = await Dio().get(result.linkDownload);
            if(response.statusCode == 200) {
                await Filesystem.exportDownloadToFilesystem('${result.title}.nzb', response.data);
                Notifications.showSnackBar(scaffoldKey, 'Downloaded NZB to your device');
            } else {
                throw Error();
            }
        } catch (error) {
            Notifications.showSnackBar(scaffoldKey, 'Failed to download NZB to your device');
        }
    }
}
