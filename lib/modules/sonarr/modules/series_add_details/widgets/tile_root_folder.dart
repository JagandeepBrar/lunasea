import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsRootFolderTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Root Folder'),
        subtitle: LSSubtitle(text: context.watch<SonarrSeriesAddDetailsState>().rootFolder?.path ?? Constants.TEXT_EMDASH),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async {
        List<SonarrRootFolder> _folders = await context.read<SonarrState>().rootFolders;
        List _values = await SonarrDialogs.editRootFolder(context, _folders);
        if(_values[0]) {
            context.read<SonarrSeriesAddDetailsState>().rootFolder = _values[1];
            SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER.put((_values[1] as SonarrRootFolder).id);
        }
    }
}
