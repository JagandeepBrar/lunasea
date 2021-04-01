import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliStatisticsTimeRangeButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) => Selector<TautulliState, TautulliStatisticsTimeRange>(
        selector: (_, state) => state.statisticsTimeRange,
        builder: (context, range, _) => LunaPopupMenuButton<TautulliStatisticsTimeRange>(
            tooltip: 'Time Range',
            icon: Icons.access_time,
            onSelected: (value) {
                context.read<TautulliState>().statisticsTimeRange = value;
                context.read<TautulliState>().resetStatistics();
            },
            itemBuilder: (context) => List<PopupMenuEntry<TautulliStatisticsTimeRange>>.generate(
                TautulliStatisticsTimeRange.values.length,
                (index) => PopupMenuItem<TautulliStatisticsTimeRange>(
                    value: TautulliStatisticsTimeRange.values[index],
                    child: Text(
                        TautulliStatisticsTimeRange.values[index].name,
                        style: TextStyle(
                            fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                            color: range == TautulliStatisticsTimeRange.values[index]
                                ? LunaColours.accent
                                : Colors.white,
                        ),
                    ),
                ),
            )
        ),
    );
}