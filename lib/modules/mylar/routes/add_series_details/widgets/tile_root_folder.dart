import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesAddDetailsRootFolderTile extends StatelessWidget {
  const MylarSeriesAddDetailsRootFolderTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaBlock(
      title: 'mylar.RootFolder'.tr(),
      body: [
        TextSpan(
          text: context.watch<MylarSeriesAddDetailsState>().rootFolder.path ??
              LunaUI.TEXT_EMDASH,
        ),
      ],
      trailing: const LunaIconButton.arrow(),
      onTap: () async => _onTap(context),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    List<MylarRootFolder> _folders =
        await context.read<MylarState>().rootFolders!;
    Tuple2<bool, MylarRootFolder?> result =
        await MylarDialogs().editRootFolder(context, _folders);
    if (result.item1) {
      context.read<MylarSeriesAddDetailsState>().rootFolder = result.item2!;
      MylarDatabase.ADD_SERIES_DEFAULT_ROOT_FOLDER.update(result.item2!.id);
    }
  }
}
