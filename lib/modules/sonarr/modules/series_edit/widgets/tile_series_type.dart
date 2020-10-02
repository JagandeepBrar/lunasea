import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesEditSeriesTypeTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Series Type'),
        subtitle: LSSubtitle(text: context.watch<SonarrSeriesEditState>().seriesType.value?.lsLanguage_Capitalize() ?? Constants.TEXT_EMDASH),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async {
        List _values = await SonarrDialogs.editSeriesType(context);
        if(_values[0]) context.read<SonarrSeriesEditState>().seriesType = _values[1];
    }
}
