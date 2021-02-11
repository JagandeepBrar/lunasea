import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrTagsAppBarActionAddTag extends StatelessWidget {
    final bool asDialogButton;

    RadarrTagsAppBarActionAddTag({
        Key key,
        this.asDialogButton = false,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => asDialogButton
        ? LSDialog.button(text: 'Add', textColor: Colors.white, onPressed: () async => _onPressed(context))
        : LSIconButton(icon: Icons.add, onPressed: () async => _onPressed(context));

    Future<void> _onPressed(BuildContext context) async {
        List _values = await RadarrDialogs().addNewTag(context);
        if(_values[0]) context.read<RadarrState>().api.tag.create(label: _values[1])
        .then((tag) {
            showLunaSuccessSnackBar(
                context: context,
                title: 'Added Tag',
                message: tag.label,
            );
            context.read<RadarrState>().fetchTags();
        })
        .catchError((error, stack) {
            LunaLogger().error('Failed to add tag: ${_values[1]}', error, stack);
            showLunaErrorSnackBar(
                context: context,
                title: 'Failed to Add Tag',
                error: error,
            );
        });
    }
}
