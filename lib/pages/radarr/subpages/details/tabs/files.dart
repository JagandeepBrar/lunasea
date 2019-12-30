import 'package:flutter/material.dart';
import 'package:lunasea/logic/automation/radarr.dart';
import 'package:lunasea/system/functions.dart';
import 'package:lunasea/system/ui.dart';

Widget buildFiles(RadarrCatalogueEntry entry, GlobalKey<ScaffoldState> scaffoldKey, Function refreshData, BuildContext context) {
    return Scrollbar(
        child: ListView(
            children: <Widget>[
                entry.downloaded ? (
                    Card(
                        child: ListTile(
                            title: Elements.getTitle(entry.movieFile['relativePath']),
                            subtitle: Elements.getSubtitle(
                                entry.movieFile['mediaInfo'] != null ?
                                    '${Functions.bytesToReadable(entry.movieFile['size']) ?? 'Unknown'}\t•\t' +
                                    '${entry.movieFile['quality']['quality']['name'] ?? 'Unknown'}\t•\t' +
                                    '${entry.movieFile['mediaInfo']['videoFormat'] ?? 'Unknown'}/' + 
                                    '${entry.movieFile['mediaInfo']['audioFormat'] ?? 'Unknown'}' :
                                    '${Functions.bytesToReadable(entry.movieFile['size']) ?? 'Unknown'}\t•\t' +
                                    '${entry.movieFile['quality']['quality']['name'] ?? 'Unknown'}',
                                preventOverflow: true,
                            ),
                            trailing: IconButton(
                                icon: Elements.getIcon(Icons.delete, color: Colors.red),
                                tooltip: 'Delete Movie File',
                                onPressed: () async {
                                    List<dynamic> values = await RadarrDialogs.showDeleteMovieFilePrompt(context);
                                    if(values[0]) {
                                        if(await RadarrAPI.removeMovieFile(entry.movieFile['id'])) {
                                            await refreshData();
                                            Notifications.showSnackBar(scaffoldKey, 'Movie file deleted');
                                        } else {
                                            Notifications.showSnackBar(scaffoldKey, 'Failed to delete movie file');
                                        }
                                    }
                                },
                            ),
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    )
                ) : (
                    Card(
                        child: ListTile(
                            title: Text(
                                'No Files Found',
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                ),
                            ),
                        ),
                        margin: Elements.getCardMargin(),
                        elevation: 4.0,
                    )
                ),
            ],
            padding: Elements.getListViewPadding(),
        ),
    );
}
