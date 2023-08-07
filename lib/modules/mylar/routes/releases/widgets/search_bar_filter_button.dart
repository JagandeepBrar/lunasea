import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/scroll_controller.dart';
import 'package:lunasea/modules/mylar.dart';

class MylarReleasesAppBarFilterButton extends StatefulWidget {
  final ScrollController controller;

  const MylarReleasesAppBarFilterButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<MylarReleasesAppBarFilterButton> createState() => _State();
}

class _State extends State<MylarReleasesAppBarFilterButton> {
  @override
  Widget build(BuildContext context) {
    return LunaCard(
      context: context,
      child: Consumer<MylarReleasesState>(
        builder: (context, state, _) =>
            LunaPopupMenuButton<MylarReleasesFilter>(
          tooltip: 'mylar.FilterReleases'.tr(),
          icon: Icons.filter_list_rounded,
          onSelected: (result) {
            state.filterType = result;
            widget.controller.animateToStart();
          },
          itemBuilder: (context) =>
              List<PopupMenuEntry<MylarReleasesFilter>>.generate(
            MylarReleasesFilter.values.length,
            (index) => PopupMenuItem<MylarReleasesFilter>(
              value: MylarReleasesFilter.values[index],
              child: Text(
                MylarReleasesFilter.values[index].readable,
                style: TextStyle(
                  fontSize: LunaUI.FONT_SIZE_H3,
                  color: state.filterType == MylarReleasesFilter.values[index]
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
