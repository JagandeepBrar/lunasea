import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrAppBarAddSeriesAction extends StatelessWidget {
  const SonarrAppBarAddSeriesAction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaIconButton(
      icon: Icons.add_rounded,
      onPressed: () async => SonarrAddSeriesRouter().navigateTo(
        context,
        query: '',
      ),
    );
  }
}
