import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/scroll_controller.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarSeriesSearchBarFilterButton extends StatefulWidget {
  final ScrollController controller;

  const MylarSeriesSearchBarFilterButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<MylarSeriesSearchBarFilterButton> createState() => _State();
}

class _State extends State<MylarSeriesSearchBarFilterButton> {
  @override
  Widget build(BuildContext context) => LunaCard(
        context: context,
        child: Consumer<MylarState>(
          builder: (context, state, _) =>
              LunaPopupMenuButton<MylarSeriesFilter>(
            tooltip: 'mylar.FilterCatalogue'.tr(),
            icon: Icons.filter_list_rounded,
            onSelected: (result) {
              state.seriesFilterType = result;
              widget.controller.animateToStart();
            },
            itemBuilder: (context) =>
                List<PopupMenuEntry<MylarSeriesFilter>>.generate(
              MylarSeriesFilter.values.length,
              (index) => PopupMenuItem<MylarSeriesFilter>(
                value: MylarSeriesFilter.values[index],
                child: Text(
                  MylarSeriesFilter.values[index].readable,
                  style: TextStyle(
                    fontSize: LunaUI.FONT_SIZE_H3,
                    color: state.seriesFilterType ==
                            MylarSeriesFilter.values[index]
                        ? LunaColours.accent
                        : Colors.white,
                  ),
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
