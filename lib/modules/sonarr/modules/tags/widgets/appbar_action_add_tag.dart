import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SonarrTagsAppBarActionAddTag extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSIconButton(
        icon: Icons.add,
        onPressed: () async => _onPressed(context),
    );

    Future<void> _onPressed(BuildContext context) async => LSSnackBar(
        context: context,
        title: 'Coming Soon!',
        message: 'This feature has not yet been implemented',
        type: SNACKBAR_TYPE.info,
    );
}
