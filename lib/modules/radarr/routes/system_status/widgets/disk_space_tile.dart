import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/radarr.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class RadarrDiskSpaceTile extends StatelessWidget {
    final RadarrDiskSpace diskSpace;

    RadarrDiskSpaceTile({
        Key key,
        @required this.diskSpace,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return LunaListTile(
            context: context,
            title: LunaText.title(text: diskSpace.lunaPath),
            subtitle: Stack(
                children: [
                    LunaText.subtitle(text: '${diskSpace.lunaSpace}\n', maxLines: 2),
                    percentBar(),
                ],
            ),
            trailing: LunaIconButton(
                text: diskSpace.lunaPercentageString,
                color: diskSpace.lunaColor,
                textSize: 11.0,
            ),
            contentPadding: true,
        );
    }

    Widget percentBar() {
        return LinearPercentIndicator(
            percent: (diskSpace.lunaPercentage ?? 0)/100,
            padding: EdgeInsets.only(left: 2.0, right: 2.0, top: 26.0),
            progressColor: diskSpace.lunaColor,
            backgroundColor: diskSpace.lunaColor.withOpacity(0.30),
            lineHeight: 4.0,
        );
    }
}