import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliStatisticsTimeRangeButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) => Selector<TautulliState, TautulliStatisticsTimeRange>(
        selector: (_, state) => state.statisticsTimeRange,
        builder: (context, range, _) => PopupMenuButton<TautulliStatisticsTimeRange>(
            shape: LunaSeaDatabaseValue.THEME_AMOLED.data && LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data
                ? LSRoundedShapeWithBorder()
                : LSRoundedShape(),
            icon: LSIcon(icon: Icons.access_time),
            onSelected: (value) {
                Provider.of<TautulliState>(context, listen: false).statisticsTimeRange = value;
                Provider.of<TautulliLocalState>(context, listen: false).resetStatistics(context);
            },
            itemBuilder: (context) => List<PopupMenuEntry<TautulliStatisticsTimeRange>>.generate(
                TautulliStatisticsTimeRange.values.length,
                (index) => PopupMenuItem<TautulliStatisticsTimeRange>(
                    value: TautulliStatisticsTimeRange.values[index],
                    child: Text(
                        TautulliStatisticsTimeRange.values[index].name,
                        style: TextStyle(
                            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                            color: range == TautulliStatisticsTimeRange.values[index]
                                ? LSColors.accent
                                : Colors.white,
                        ),
                    ),
                ),
            )
        ),
    );
}