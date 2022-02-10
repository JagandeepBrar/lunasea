import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/readarr.dart';

class ReadarrReleasesAppBarFilterButton extends StatefulWidget {
  final ScrollController controller;

  const ReadarrReleasesAppBarFilterButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ReadarrReleasesAppBarFilterButton> createState() => _State();
}

class _State extends State<ReadarrReleasesAppBarFilterButton> {
  @override
  Widget build(BuildContext context) {
    return LunaCard(
      context: context,
      child: Consumer<ReadarrReleasesState>(
        builder: (context, state, _) =>
            LunaPopupMenuButton<ReadarrReleasesFilter>(
          tooltip: 'readarr.FilterReleases'.tr(),
          icon: Icons.filter_list_rounded,
          onSelected: (result) {
            state.filterType = result;
            widget.controller.lunaAnimateToStart();
          },
          itemBuilder: (context) =>
              List<PopupMenuEntry<ReadarrReleasesFilter>>.generate(
            ReadarrReleasesFilter.values.length,
            (index) => PopupMenuItem<ReadarrReleasesFilter>(
              value: ReadarrReleasesFilter.values[index],
              child: Text(
                ReadarrReleasesFilter.values[index].readable,
                style: TextStyle(
                  fontSize: LunaUI.FONT_SIZE_H3,
                  color: state.filterType == ReadarrReleasesFilter.values[index]
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
      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 12.0, 14.0),
      color: Theme.of(context).canvasColor,
    );
  }
}
