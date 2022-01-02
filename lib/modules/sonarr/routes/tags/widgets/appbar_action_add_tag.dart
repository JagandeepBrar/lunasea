import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrTagsAppBarActionAddTag extends StatelessWidget {
  final bool asDialogButton;

  const SonarrTagsAppBarActionAddTag({
    Key? key,
    this.asDialogButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (asDialogButton)
      return LunaDialog.button(
        text: 'lunasea.Add'.tr(),
        textColor: Colors.white,
        onPressed: () async => _onPressed(context),
      );
    return LunaIconButton(
      icon: Icons.add_rounded,
      onPressed: () async => _onPressed(context),
    );
  }

  Future<void> _onPressed(BuildContext context) async {
    Tuple2<bool, String> result = await SonarrDialogs().addNewTag(context);
    if (result.item1)
      SonarrAPIController()
          .addTag(context: context, label: result.item2)
          .then((value) {
        if (value) context.read<SonarrState>().fetchTags();
      });
  }
}
