import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrAuthorSearchBarFilterButton extends StatefulWidget {
  final ScrollController controller;

  const ReadarrAuthorSearchBarFilterButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ReadarrAuthorSearchBarFilterButton> createState() => _State();
}

class _State extends State<ReadarrAuthorSearchBarFilterButton> {
  @override
  Widget build(BuildContext context) => LunaCard(
        context: context,
        child: Consumer<ReadarrState>(
          builder: (context, state, _) =>
              LunaPopupMenuButton<ReadarrAuthorFilter>(
            tooltip: 'readarr.FilterCatalogue'.tr(),
            icon: Icons.filter_list_rounded,
            onSelected: (result) {
              state.seriesFilterType = result;
              widget.controller.lunaAnimateToStart();
            },
            itemBuilder: (context) =>
                List<PopupMenuEntry<ReadarrAuthorFilter>>.generate(
              ReadarrAuthorFilter.values.length,
              (index) => PopupMenuItem<ReadarrAuthorFilter>(
                value: ReadarrAuthorFilter.values[index],
                child: Text(
                  ReadarrAuthorFilter.values[index].readable,
                  style: TextStyle(
                    fontSize: LunaUI.FONT_SIZE_H3,
                    color: state.seriesFilterType ==
                            ReadarrAuthorFilter.values[index]
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
