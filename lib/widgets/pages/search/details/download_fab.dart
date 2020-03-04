import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lunasea/widgets/ui.dart';
import 'package:lunasea/core.dart';

class LSSearchDetailsDownloadFAB extends StatelessWidget {
    final GlobalKey<ScaffoldState> scaffoldKey;

    LSSearchDetailsDownloadFAB({
        @required this.scaffoldKey,
    });
    
    @override
    Widget build(BuildContext context) => LSFloatingActionButton(
        icon: Icons.file_download,
        backgroundColor: Colors.orange,
        onPressed: () => _downloadToFilesystem(context),
    );

    Future<void> _downloadToFilesystem(BuildContext context) async {
        List _prompt = await LSDialogSearch.downloadNZB(context);
        if(_prompt[0]) {
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
}