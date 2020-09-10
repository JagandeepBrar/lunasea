import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliGraphsTypeButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) => Selector<TautulliState, TautulliGraphYAxis>(
        selector: (_, state) => state.graphYAxis,
        builder: (context, type, _) => PopupMenuButton<TautulliGraphYAxis>(
            shape: LunaSeaDatabaseValue.THEME_AMOLED.data && LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data
                ? LSRoundedShapeWithBorder()
                : LSRoundedShape(),
            icon: LSIcon(icon: Icons.merge_type),
            onSelected: (value) {
                Provider.of<TautulliState>(context, listen: false).graphYAxis = value;
                Provider.of<TautulliLocalState>(context, listen: false).resetAllPlayPeriodGraphs(context);
                Provider.of<TautulliLocalState>(context, listen: false).resetAllStreamInformationGraphs(context);
            },
            itemBuilder: (context) => List<PopupMenuEntry<TautulliGraphYAxis>>.generate(
                TautulliStatsType.values.length,
                (index) => PopupMenuItem<TautulliGraphYAxis>(
                    value: TautulliGraphYAxis.values[index],
                    child: Text(
                        TautulliStatsType.values[index].value.lsLanguage_Capitalize(),
                        style: TextStyle(
                            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                            color: type == TautulliGraphYAxis.values[index]
                                ? LSColors.accent
                                : Colors.white,
                        ),
                    ),
                ),
            )
        ),
    );
}