import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class TautulliActivityDetailsMetadata extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSIconButton(
        icon: Icons.info_outline,
        onPressed: () async => _onPressed(context),
    );

    Future<void> _onPressed(BuildContext context) => LSSnackBar(
        context: context,
        title: 'Coming Soon!',
        message: 'Library data has not yet been implemented',
        type: SNACKBAR_TYPE.info,
    );
}
