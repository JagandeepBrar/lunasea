import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrCatalogueSortButton extends StatefulWidget {
  final ScrollController controller;

  LidarrCatalogueSortButton({
    Key key,
    @required this.controller,
  }) : super(key: key);

  @override
  State<LidarrCatalogueSortButton> createState() => _State();
}

class _State extends State<LidarrCatalogueSortButton> {
  @override
  Widget build(BuildContext context) => LunaCard(
        context: context,
        height: LunaTextInputBar.appBarInnerHeight,
        width: LunaTextInputBar.appBarInnerHeight,
        child: Consumer<LidarrState>(
          builder: (context, model, _) =>
              LunaPopupMenuButton<LidarrCatalogueSorting>(
            tooltip: 'Sort Catalogue',
            icon: Icons.sort,
            onSelected: (result) {
              if (model.sortCatalogueType == result) {
                model.sortCatalogueAscending = !model.sortCatalogueAscending;
              } else {
                model.sortCatalogueAscending = true;
                model.sortCatalogueType = result;
              }
              widget.controller.lunaAnimateToStart();
            },
            itemBuilder: (context) =>
                List<PopupMenuEntry<LidarrCatalogueSorting>>.generate(
              LidarrCatalogueSorting.values.length,
              (index) => PopupMenuItem<LidarrCatalogueSorting>(
                value: LidarrCatalogueSorting.values[index],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LidarrCatalogueSorting.values[index].readable,
                      style: TextStyle(
                        fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                      ),
                    ),
                    if (model.sortCatalogueType ==
                        LidarrCatalogueSorting.values[index])
                      Icon(
                        model.sortCatalogueAscending
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        size: LunaUI.FONT_SIZE_SUBTITLE + 2.0,
                        color: LunaColours.accent,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        margin: EdgeInsets.zero,
        color: Theme.of(context).canvasColor,
      );
}
