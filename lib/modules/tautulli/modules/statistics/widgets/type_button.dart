import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliStatisticsTypeButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) => Selector<TautulliState, TautulliStatsType>(
        selector: (_, state) => state.statisticsType,
        builder: (context, type, _) => PopupMenuButton<TautulliStatsType>(
            shape: LunaSeaDatabaseValue.THEME_AMOLED.data && LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data
                ? LSRoundedShapeWithBorder()
                : LSRoundedShape(),
            icon: LSIcon(icon: Icons.merge_type),
            onSelected: (value) {
                Provider.of<TautulliState>(context, listen: false).statisticsType = value;
                Provider.of<TautulliLocalState>(context, listen: false).resetStatistics(context);
            },
            itemBuilder: (context) => List<PopupMenuEntry<TautulliStatsType>>.generate(
                TautulliStatsType.values.length,
                (index) => PopupMenuItem<TautulliStatsType>(
                    value: TautulliStatsType.values[index],
                    child: Text(
                        TautulliStatsType.values[index].value.lsLanguage_Capitalize(),
                        style: TextStyle(
                            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                            color: type == TautulliStatsType.values[index]
                                ? LSColors.accent
                                : Colors.white,
                        ),
                    ),
                ),
            )
        ),
    );
}