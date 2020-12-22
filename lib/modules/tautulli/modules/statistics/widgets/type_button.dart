import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';
import 'package:tautulli/tautulli.dart';

class TautulliStatisticsTypeButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) => Selector<TautulliState, TautulliStatsType>(
        selector: (_, state) => state.statisticsType,
        builder: (context, type, _) => PopupMenuButton<TautulliStatsType>(
            shape: LunaDatabaseValue.THEME_AMOLED.data && LunaDatabaseValue.THEME_AMOLED_BORDER.data
                ? LSRoundedShapeWithBorder()
                : LSRoundedShape(),
            icon: LSIcon(icon: Icons.merge_type),
            onSelected: (value) {
                context.read<TautulliState>().statisticsType = value;
                context.read<TautulliState>().resetStatistics();
            },
            itemBuilder: (context) => List<PopupMenuEntry<TautulliStatsType>>.generate(
                TautulliStatsType.values.length,
                (index) => PopupMenuItem<TautulliStatsType>(
                    value: TautulliStatsType.values[index],
                    child: Text(
                        TautulliStatsType.values[index].value.lunaCapitalizeFirstLetters(),
                        style: TextStyle(
                            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                            color: type == TautulliStatsType.values[index]
                                ? LunaColours.accent
                                : Colors.white,
                        ),
                    ),
                ),
            )
        ),
    );
}