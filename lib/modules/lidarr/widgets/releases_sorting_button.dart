import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrReleasesSortButton extends StatefulWidget {
    final ScrollController controller;

    LidarrReleasesSortButton({
        Key key,
        @required this.controller,
    }): super(key: key);

    @override
    State<LidarrReleasesSortButton> createState() => _State();
}

class _State extends State<LidarrReleasesSortButton> {    
    @override
    Widget build(BuildContext context) => LunaCard(
        context: context,
        child: Consumer<LidarrState>(
            builder: (context, model, _) => LunaPopupMenuButton<LidarrReleasesSorting>(
                tooltip: 'Sort Releases',
                icon: Icons.sort,
                onSelected: (result) {
                    if(model.sortReleasesType == result) {
                        model.sortReleasesAscending = !model.sortReleasesAscending;
                    } else {
                        model.sortReleasesAscending = true;
                        model.sortReleasesType = result;
                    }
                    widget.controller.lunaAnimateToStart();
                },
                itemBuilder: (context) => List<PopupMenuEntry<LidarrReleasesSorting>>.generate(
                    LidarrReleasesSorting.values.length,
                    (index) => PopupMenuItem<LidarrReleasesSorting>(
                        value: LidarrReleasesSorting.values[index],
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Text(
                                    LidarrReleasesSorting.values[index].readable,
                                    style: TextStyle(
                                        fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                                    ),
                                ),
                                if(model.sortReleasesType == LidarrReleasesSorting.values[index]) Icon(
                                    model.sortReleasesAscending
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    size: LunaUI.FONT_SIZE_SUBTITLE+2.0,
                                    color: LunaColours.accent,
                                ),
                            ],
                        ),
                    ),
                ),
            ), 
        ),
        margin: LunaTextInputBar.appBarMargin.subtract(EdgeInsets.only(left: 12.0)),
        color: Theme.of(context).canvasColor,
    );
}
