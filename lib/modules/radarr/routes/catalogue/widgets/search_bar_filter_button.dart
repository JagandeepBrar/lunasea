import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/extensions/scroll_controller.dart';
import 'package:lunasea/modules/radarr.dart';

class RadarrCatalogueSearchBarFilterButton extends StatefulWidget {
  final ScrollController controller;

  const RadarrCatalogueSearchBarFilterButton({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<RadarrCatalogueSearchBarFilterButton> createState() => _State();
}

class _State extends State<RadarrCatalogueSearchBarFilterButton> {
  @override
  Widget build(BuildContext context) {
    return LunaCard(
      context: context,
      child: Consumer<RadarrState>(
        builder: (context, state, _) => LunaPopupMenuButton<RadarrMoviesFilter>(
          tooltip: 'radarr.FilterCatalogue'.tr(),
          icon: LunaIcons.FILTER,
          onSelected: (result) {
            state.moviesFilterType = result;
            widget.controller.animateToStart();
          },
          itemBuilder: (context) =>
              List<PopupMenuEntry<RadarrMoviesFilter>>.generate(
            RadarrMoviesFilter.values.length,
            (index) => PopupMenuItem<RadarrMoviesFilter>(
              value: RadarrMoviesFilter.values[index],
              child: Text(
                RadarrMoviesFilter.values[index].readable,
                style: TextStyle(
                  fontSize: LunaUI.FONT_SIZE_H3,
                  color:
                      state.moviesFilterType == RadarrMoviesFilter.values[index]
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
}
