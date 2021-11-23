import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAddMovieDetailsRootFolderTile extends StatelessWidget {
  const RadarrAddMovieDetailsRootFolderTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaListTile(
      context: context,
      title: LunaText.title(text: 'radarr.RootFolder'.tr()),
      subtitle: Selector<RadarrAddMovieDetailsState, RadarrRootFolder>(
        selector: (_, state) => state.rootFolder,
        builder: (context, folder, _) =>
            LunaText.subtitle(text: folder?.path ?? LunaUI.TEXT_EMDASH),
      ),
      trailing: LunaIconButton(icon: Icons.arrow_forward_ios_rounded),
      onTap: () async {
        List<RadarrRootFolder> folders =
            await context.read<RadarrState>().rootFolders;
        Tuple2<bool, RadarrRootFolder> values =
            await RadarrDialogs().editRootFolder(context, folders);
        if (values.item1)
          context.read<RadarrAddMovieDetailsState>().rootFolder = values.item2;
      },
    );
  }
}
