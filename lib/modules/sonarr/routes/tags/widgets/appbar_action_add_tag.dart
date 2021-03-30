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
    Widget build(BuildContext context) => asDialogButton
        ? LSDialog.button(text: 'Add', textColor: Colors.white, onPressed: () async => _onPressed(context))
        : LSIconButton(icon: Icons.add, onPressed: () async => _onPressed(context));

    Future<void> _onPressed(BuildContext context) async {
        List _values = await SonarrDialogs.addNewTag(context);
        if(_values[0]) context.read<SonarrState>().api.tag.addTag(label: _values[1])
        .then((tag) {
            showLunaSuccessSnackBar(
                title: 'Added Tag',
                message: tag.label,
            );
            context.read<SonarrState>().resetTags();
        })
        .catchError((error, stack) {
            LunaLogger().error('Failed to add tag: ${_values[1]}', error, stack);
            showLunaErrorSnackBar(
                title: 'Failed to Add Tag',
                error: error,
            );
        });
    }
}
