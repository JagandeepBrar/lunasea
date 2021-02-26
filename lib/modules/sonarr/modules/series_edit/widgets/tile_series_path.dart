import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesEditSeriesPathTile extends StatelessWidget {
    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: 'Series Path'),
        subtitle: LSSubtitle(text: context.watch<SonarrSeriesEditState>().seriesPath ?? Constants.TEXT_EMDASH),
        trailing: LSIconButton(icon: Icons.arrow_forward_ios_rounded),
        onTap: () async => _onTap(context),
    );

    Future<void> _onTap(BuildContext context) async {
        Tuple2<bool, String> _values = await LunaDialogs().editText(
            context,
            'Series Path',
            prefill: context.read<SonarrSeriesEditState>().seriesPath,
        );
        if(_values.item1) context.read<SonarrSeriesEditState>().seriesPath = _values.item2;
    }
}
