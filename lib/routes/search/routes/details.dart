import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/widgets/ui.dart';

class SearchDetails extends StatefulWidget {
    static const ROUTE_NAME = '/search/details';

    @override
    State<SearchDetails> createState() =>  _State();
}

class _State extends State<SearchDetails> {
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        appBar: _appBar,
        floatingActionButton: _floatingActionButton,
        body: _body,
    );

    Widget get _appBar {
        final details = Provider.of<SearchModel>(context, listen: false).resultDetails;
        return LSAppBar(
            title: details?.title ?? 'Result Details',
            actions: <Widget>[
                if(details?.linkComments != '') LSIconButton(
                    icon: Icons.link,
                    onPressed: () => details?.linkComments?.lsLinks_OpenLink(),
                ),
            ],
        );
    }

    Widget get _body => LSListView(
        children: <Widget>[
            Consumer<SearchModel>(
                builder: (context, _state, child) => LSCardTile(
                    title: LSTitle(text: 'Title'),
                    subtitle: LSSubtitle(text: _state?.resultDetails?.title ?? 'Unknown'),
                    trailing: LSIconButton(icon: Icons.arrow_forward_ios),
                    onTap: () => SystemDialogs.showTextPreviewPrompt(context, 'Title', _state?.resultDetails?.title ?? 'Unknown'),
                ),
            ),
        ],
        padBottom: true,
    );

    Widget get _floatingActionButton => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
            Padding(
                child: LSFloatingActionButton(
                    icon: Icons.file_download,
                    backgroundColor: Colors.orange,
                    onPressed: _downloadToFilesystem,
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0),
            ),
            LSFloatingActionButton(
                icon: Icons.screen_share,
                onPressed: _sendToClient,
            ),
        ],
    );

    Future<void> _sendToClient() async {

    }

    Future<void> _downloadToFilesystem() async {
        List _prompt = await LSDialogSearch.downloadNZB(context);
        if(_prompt[0]) {
            Notifications.showSnackBar(_scaffoldKey, 'Downloading NZB...');
            try {
                final result = Provider.of<SearchModel>(context, listen: false).resultDetails;
                Response response = await Dio().get(result.linkDownload);
                if(response.statusCode == 200) {
                    await Filesystem.exportDownloadToFilesystem('${result.title}.nzb', response.data);
                    Notifications.showSnackBar(_scaffoldKey, 'Downloaded NZB to your device');
                } else {
                    throw Error();
                }
            } catch (error) {
                Notifications.showSnackBar(_scaffoldKey, 'Failed to download NZB to your device');
            }
        }
    }
}
