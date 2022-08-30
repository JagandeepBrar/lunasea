import 'package:flutter/material.dart';
import 'package:lunasea/router/routes/sonarr.dart';
import 'package:lunasea/widgets/ui.dart';

class SonarrAppBarAddSeriesAction extends StatelessWidget {
  const SonarrAppBarAddSeriesAction({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LunaIconButton(
      icon: Icons.add_rounded,
      onPressed: SonarrRoutes.ADD_SERIES.go,
    );
  }
}
