import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class LSSearchDetailsClientFAB extends StatelessWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;

    LSSearchDetailsClientFAB({
        @required this.scaffoldKey,
    });

    @override
    Widget build(BuildContext context) => LSFloatingActionButton(
        icon: Icons.screen_share,
        onPressed: () => _sendToClient(context),
    );

    Future<void> _sendToClient(BuildContext context) async {
        List _values = await LSDialogSearch.sendToClient(context);
        if(_values[0]) {
            final _result = Provider.of<SearchModel>(context, listen: false).resultDetails;
            switch(_values[1]) {
                case 'sabnzbd': _sendToSABnzbd(context, _result); break;
                case 'nzbget': _sendToNZBGet(context, _result); break;
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
}
