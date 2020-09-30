import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsRootFolderTile extends StatefulWidget {
    final SonarrSeriesLookup series;
    final List<SonarrRootFolder> rootFolder;

    SonarrSeriesAddDetailsRootFolderTile({
        Key key,
        @required this.series,
        @required this.rootFolder,
    }) : super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SonarrSeriesAddDetailsRootFolderTile> {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Root Folder'),
        subtitle: ValueListenableBuilder(
            valueListenable: Database.lunaSeaBox.listenable(keys: [SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER.key]),
            builder: (context, box, _) => LSSubtitle(
                text: widget.rootFolder.firstWhere(
                    (element) => element.id == SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER.data,
                    orElse: () => null,
                )?.path ?? Constants.TEXT_EMDASH,
            ),
        ),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: _onTap,
    );

    Future<void> _onTap() async {
        List _values = await SonarrDialogs.editRootFolder(context, widget.rootFolder);
        if(_values[0]) {
            SonarrRootFolder _folder = _values[1];
            widget.series.rootFolderPath = _folder.path;
            SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER.put(_folder.id);
        }
    }
}
