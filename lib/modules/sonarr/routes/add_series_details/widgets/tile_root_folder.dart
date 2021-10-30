import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesAddDetailsRootFolderTile extends StatelessWidget {
  const SonarrSeriesAddDetailsRootFolderTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'Root Folder'),
      subtitle: LunaText.subtitle(
          text: context.watch<SonarrSeriesAddDetailsState>().rootFolder?.path ??
              LunaUI.TEXT_EMDASH),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    List<SonarrRootFolder> _folders =
        await context.read<SonarrState>().rootFolders;
    Tuple2<bool, SonarrRootFolder> result =
        await SonarrDialogs().editRootFolder(context, _folders);
    if (result.item1) {
      context.read<SonarrSeriesAddDetailsState>().rootFolder = result.item2;
      SonarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER.put(result.item2.id);
    }
  }
}
