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
        Tuple2<bool, String> values = await RadarrDialogs().addNewTag(context);
        if(values.item1) context.read<RadarrState>().api.tag.create(label: values.item2)
        .then((tag) {
            showLunaSuccessSnackBar(
                context: context,
                title: 'Added Tag',
                message: tag.label,
            );
            context.read<RadarrState>().fetchTags();
        })
        .catchError((error, stack) {
            LunaLogger().error('Failed to add tag: ${values.item2}', error, stack);
            showLunaErrorSnackBar(
                context: context,
                title: 'Failed to Add Tag',
                error: error,
            );
        });
    }
}
