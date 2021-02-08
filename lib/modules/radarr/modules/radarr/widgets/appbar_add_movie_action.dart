import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrAppBarAddMoviesAction extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSIconButton(
        icon: Icons.add,
        onPressed: () async => _onPressed(context),
    );

    Future<void> _onPressed(BuildContext context) async => RadarrAddMovieRouter().navigateTo(context);
}
