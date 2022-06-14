import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/scroll_controller.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesSearchBarSortButton extends StatefulWidget {
  final ScrollController controller;

  const SonarrSeriesSearchBarSortButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<SonarrSeriesSearchBarSortButton> createState() => _State();
}

class _State extends State<SonarrSeriesSearchBarSortButton> {
  @override
  Widget build(BuildContext context) => LunaCard(
        context: context,
        child: Consumer<SonarrState>(
          builder: (context, state, _) =>
              LunaPopupMenuButton<SonarrSeriesSorting>(
            tooltip: 'sonarr.SortCatalogue'.tr(),
            icon: Icons.sort_rounded,
            onSelected: (result) {
              if (state.seriesSortType == result) {
                state.seriesSortAscending = !state.seriesSortAscending;
              } else {
                state.seriesSortAscending = true;
                state.seriesSortType = result;
              }
              widget.controller.animateToStart();
            },
            itemBuilder: (context) =>
                List<PopupMenuEntry<SonarrSeriesSorting>>.generate(
              SonarrSeriesSorting.values.length,
              (index) => PopupMenuItem<SonarrSeriesSorting>(
                value: SonarrSeriesSorting.values[index],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      SonarrSeriesSorting.values[index].readable,
                      style: TextStyle(
                        fontSize: LunaUI.FONT_SIZE_H3,
                        color: state.seriesSortType ==
                                SonarrSeriesSorting.values[index]
                            ? LunaColours.accent
                            : Colors.white,
                      ),
                    ),
                    if (state.seriesSortType ==
                        SonarrSeriesSorting.values[index])
                      Icon(
                        state.seriesSortAscending
                            ? Icons.arrow_upward_rounded
                            : Icons.arrow_downward_rounded,
                        size: LunaUI.FONT_SIZE_H2,
                        color: LunaColours.accent,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        height: LunaTextInputBar.defaultHeight,
        width: LunaTextInputBar.defaultHeight,
        margin: const EdgeInsets.only(left: LunaUI.DEFAULT_MARGIN_SIZE),
        color: Theme.of(context).canvasColor,
      );
}
