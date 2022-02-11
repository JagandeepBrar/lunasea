import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrReleasesAppBarSortButton extends StatefulWidget {
  final ScrollController controller;

  const ReadarrReleasesAppBarSortButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ReadarrReleasesAppBarSortButton> createState() => _State();
}

class _State extends State<ReadarrReleasesAppBarSortButton> {
  @override
  Widget build(BuildContext context) {
    return LunaCard(
      context: context,
      child: Consumer<ReadarrReleasesState>(
        builder: (context, state, _) =>
            LunaPopupMenuButton<ReadarrReleasesSorting>(
          tooltip: 'readarr.SortReleases'.tr(),
          icon: Icons.sort_rounded,
          onSelected: (result) {
            if (state.sortType == result) {
              state.sortAscending = !state.sortAscending;
            } else {
              state.sortAscending = true;
              state.sortType = result;
            }
            widget.controller.lunaAnimateToStart();
          },
          itemBuilder: (context) =>
              List<PopupMenuEntry<ReadarrReleasesSorting>>.generate(
            ReadarrReleasesSorting.values.length,
            (index) => PopupMenuItem<ReadarrReleasesSorting>(
              value: ReadarrReleasesSorting.values[index],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ReadarrReleasesSorting.values[index].readable,
                    style: TextStyle(
                      fontSize: LunaUI.FONT_SIZE_H3,
                      color:
                          state.sortType == ReadarrReleasesSorting.values[index]
                              ? LunaColours.accent
                              : Colors.white,
                    ),
                  ),
                  if (state.sortType == ReadarrReleasesSorting.values[index])
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
