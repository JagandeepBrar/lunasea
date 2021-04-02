import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrTagsAppBarActionAddTag extends StatelessWidget {
    final bool asDialogButton;

    SonarrTagsAppBarActionAddTag({
        Key key,
        this.asDialogButton = false,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        if(asDialogButton) return LunaDialog.button(
            text: 'Add',
            textColor: Colors.white,
            onPressed: () async => _onPressed(context),
        );
        return LunaIconButton(
            icon: Icons.add,
            onPressed: () async => _onPressed(context),
        );
    }

    Future<void> _onPressed(BuildContext context) async {
        Tuple2<bool, String> result = await SonarrDialogs().addNewTag(context);
        if(result.item1) context.read<SonarrState>().api.tag.addTag(label: result.item2)
        .then((tag) {
            showLunaSuccessSnackBar(title: 'Added Tag', message: tag.label);
            context.read<SonarrState>().resetTags();
        })
        .catchError((error, stack) {
            LunaLogger().error('Failed to add tag: ${result.item2}', error, stack);
            showLunaErrorSnackBar(title: 'Failed to Add Tag', error: error);
        });
    }
}
