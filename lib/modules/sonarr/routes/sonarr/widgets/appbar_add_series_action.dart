import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAppBarAddSeriesAction extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LunaIconButton(
        icon: Icons.add,
        onPressed: () async => _onPressed(context),
    );

    Future<void> _onPressed(BuildContext context) async => SonarrAddSeriesRouter().navigateTo(
        context,
        query: '',
    );
}
