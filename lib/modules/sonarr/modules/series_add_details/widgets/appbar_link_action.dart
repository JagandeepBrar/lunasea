import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class SonarrSeriesDetailsAppbarLinkAction extends StatelessWidget {
    final int tvdbId;

    SonarrSeriesDetailsAppbarLinkAction({
        Key key,
        @required this.tvdbId,
    }) : super(key: key);
    @override
    Widget build(BuildContext context) => LSIconButton(
        icon: Icons.link,
        onPressed: () async => tvdbId?.toString()?.lsLinks_OpenTVDB(),
    );
}