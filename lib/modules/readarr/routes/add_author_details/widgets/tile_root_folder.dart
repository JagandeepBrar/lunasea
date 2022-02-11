import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorAddDetailsRootFolderTile extends StatelessWidget {
  const ReadarrAuthorAddDetailsRootFolderTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'readarr.RootFolder'.tr(),
      body: [
        TextSpan(
          text: context.watch<ReadarrAuthorAddDetailsState>().rootFolder.path ??
              LunaUI.TEXT_EMDASH,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    List<ReadarrRootFolder> _folders =
        await context.read<ReadarrState>().rootFolders!;
    Tuple2<bool, ReadarrRootFolder?> result =
        await ReadarrDialogs().editRootFolder(context, _folders);
    if (result.item1) {
      context.read<ReadarrAuthorAddDetailsState>().rootFolder = result.item2!;
      ReadarrDatabaseValue.ADD_SERIES_DEFAULT_ROOT_FOLDER.put(result.item2!.id);
    }
  }
}
