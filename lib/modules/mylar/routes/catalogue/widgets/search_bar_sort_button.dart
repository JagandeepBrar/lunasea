import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/scroll_controller.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesSearchBarSortButton extends StatefulWidget {
  final ScrollController controller;

  const MylarSeriesSearchBarSortButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<MylarSeriesSearchBarSortButton> createState() => _State();
}

class _State extends State<MylarSeriesSearchBarSortButton> {
  @override
  Widget build(BuildContext context) => LunaCard(
        context: context,
        child: Consumer<MylarState>(
          builder: (context, state, _) =>
              LunaPopupMenuButton<MylarSeriesSorting>(
            tooltip: 'mylar.SortCatalogue'.tr(),
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
                List<PopupMenuEntry<MylarSeriesSorting>>.generate(
              MylarSeriesSorting.values.length,
              (index) => PopupMenuItem<MylarSeriesSorting>(
                value: MylarSeriesSorting.values[index],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      MylarSeriesSorting.values[index].readable,
                      style: TextStyle(
                        fontSize: LunaUI.FONT_SIZE_H3,
                        color: state.seriesSortType ==
                                MylarSeriesSorting.values[index]
                            ? LunaColours.accent
                            : Colors.white,
                      ),
                    ),
                    if (state.seriesSortType ==
                        MylarSeriesSorting.values[index])
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
