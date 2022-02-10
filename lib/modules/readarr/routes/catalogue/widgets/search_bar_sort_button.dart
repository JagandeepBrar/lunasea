import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorSearchBarSortButton extends StatefulWidget {
  final ScrollController controller;

  const ReadarrAuthorSearchBarSortButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ReadarrAuthorSearchBarSortButton> createState() => _State();
}

class _State extends State<ReadarrAuthorSearchBarSortButton> {
  @override
  Widget build(BuildContext context) => LunaCard(
        context: context,
        child: Consumer<ReadarrState>(
          builder: (context, state, _) =>
              LunaPopupMenuButton<ReadarrAuthorSorting>(
            tooltip: 'readarr.SortCatalogue'.tr(),
            icon: Icons.sort_rounded,
            onSelected: (result) {
              if (state.seriesSortType == result) {
                state.seriesSortAscending = !state.seriesSortAscending;
              } else {
                state.seriesSortAscending = true;
                state.seriesSortType = result;
              }
              widget.controller.lunaAnimateToStart();
            },
            itemBuilder: (context) =>
                List<PopupMenuEntry<ReadarrAuthorSorting>>.generate(
              ReadarrAuthorSorting.values.length,
              (index) => PopupMenuItem<ReadarrAuthorSorting>(
                value: ReadarrAuthorSorting.values[index],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ReadarrAuthorSorting.values[index].readable,
                      style: TextStyle(
                        fontSize: LunaUI.FONT_SIZE_H3,
                        color: state.seriesSortType ==
                                ReadarrAuthorSorting.values[index]
                            ? LunaColours.accent
                            : Colors.white,
                      ),
                    ),
                    if (state.seriesSortType ==
                        ReadarrAuthorSorting.values[index])
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
