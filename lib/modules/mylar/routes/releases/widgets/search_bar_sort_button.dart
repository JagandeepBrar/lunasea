import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/scroll_controller.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarReleasesAppBarSortButton extends StatefulWidget {
  final ScrollController controller;

  const MylarReleasesAppBarSortButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<MylarReleasesAppBarSortButton> createState() => _State();
}

class _State extends State<MylarReleasesAppBarSortButton> {
  @override
  Widget build(BuildContext context) {
    return LunaCard(
      context: context,
      child: Consumer<MylarReleasesState>(
        builder: (context, state, _) =>
            LunaPopupMenuButton<MylarReleasesSorting>(
          tooltip: 'mylar.SortReleases'.tr(),
          icon: Icons.sort_rounded,
          onSelected: (result) {
            if (state.sortType == result) {
              state.sortAscending = !state.sortAscending;
            } else {
              state.sortAscending = true;
              state.sortType = result;
            }
            widget.controller.animateToStart();
          },
          itemBuilder: (context) =>
              List<PopupMenuEntry<MylarReleasesSorting>>.generate(
            MylarReleasesSorting.values.length,
            (index) => PopupMenuItem<MylarReleasesSorting>(
              value: MylarReleasesSorting.values[index],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    MylarReleasesSorting.values[index].readable,
                    style: TextStyle(
                      fontSize: LunaUI.FONT_SIZE_H3,
                      color:
                          state.sortType == MylarReleasesSorting.values[index]
                              ? LunaColours.accent
                              : Colors.white,
                    ),
                  ),
                  if (state.sortType == MylarReleasesSorting.values[index])
                    Icon(
                      state.sortAscending
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
      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 13.5),
      color: Theme.of(context).canvasColor,
    );
  }
}
