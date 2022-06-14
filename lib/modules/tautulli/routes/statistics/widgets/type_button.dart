import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/string/string.dart';
import 'package:lunasea/modules/tautulli.dart';

class TautulliStatisticsTypeButton extends StatelessWidget {
  const TautulliStatisticsTypeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Selector<TautulliState, TautulliStatsType>(
        selector: (_, state) => state.statisticsType,
        builder: (context, type, _) => LunaPopupMenuButton<TautulliStatsType>(
            tooltip: 'Statistics Type',
            icon: Icons.merge_type_rounded,
            onSelected: (value) {
              context.read<TautulliState>().statisticsType = value;
              context.read<TautulliState>().resetStatistics();
            },
            itemBuilder: (context) =>
                List<PopupMenuEntry<TautulliStatsType>>.generate(
                  TautulliStatsType.values.length,
                  (index) => PopupMenuItem<TautulliStatsType>(
                    value: TautulliStatsType.values[index],
                    child: Text(
                      TautulliStatsType.values[index].value!.toTitleCase(),
                      style: TextStyle(
                        fontSize: LunaUI.FONT_SIZE_H3,
                        color: type == TautulliStatsType.values[index]
                            ? LunaColours.accent
                            : Colors.white,
                      ),
                    ),
                  ),
                )),
      );
}
