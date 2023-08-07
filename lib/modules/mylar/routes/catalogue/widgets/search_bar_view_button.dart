import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/scroll_controller.dart';
import 'package:lunasea/modules/mylar.dart';
import 'package:lunasea/types/list_view_option.dart';

class MylarSeriesSearchBarViewButton extends StatefulWidget {
  final ScrollController controller;

  const MylarSeriesSearchBarViewButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<MylarSeriesSearchBarViewButton> createState() => _State();
}

class _State extends State<MylarSeriesSearchBarViewButton> {
  @override
  Widget build(BuildContext context) {
    return LunaCard(
      context: context,
      child: Consumer<MylarState>(
        builder: (context, state, _) => LunaPopupMenuButton<LunaListViewOption>(
          tooltip: 'lunasea.View'.tr(),
          icon: LunaIcons.VIEW,
          onSelected: (result) {
            state.seriesViewType = result;
            widget.controller.animateToStart();
          },
          itemBuilder: (context) =>
              List<PopupMenuEntry<LunaListViewOption>>.generate(
            LunaListViewOption.values.length,
            (index) => PopupMenuItem<LunaListViewOption>(
              value: LunaListViewOption.values[index],
              child: Text(
                LunaListViewOption.values[index].readable,
                style: TextStyle(
                  fontSize: LunaUI.FONT_SIZE_H3,
                  color:
                      state.seriesViewType == LunaListViewOption.values[index]
                          ? LunaColours.accent
                          : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      margin: const EdgeInsets.only(left: LunaUI.DEFAULT_MARGIN_SIZE),
      color: Theme.of(context).canvasColor,
      height: LunaTextInputBar.defaultHeight,
      width: LunaTextInputBar.defaultHeight,
    );
  }
}
