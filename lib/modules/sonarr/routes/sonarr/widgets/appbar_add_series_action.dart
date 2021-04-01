import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAppBarAddSeriesAction extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return LunaIconButton(
            icon: Icons.add,
            onPressed: () async => SonarrAddSeriesRouter().navigateTo(
                context,
                query: '',
            ),
        );
    }
}
