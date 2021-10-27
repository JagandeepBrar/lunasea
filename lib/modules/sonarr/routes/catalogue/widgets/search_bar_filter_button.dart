import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesSearchBarFilterButton extends StatefulWidget {
  final ScrollController controller;

  SonarrSeriesSearchBarFilterButton({
    Key key,
    @required this.controller,
  }) : super(key: key);

  @override
  State<SonarrSeriesSearchBarFilterButton> createState() => _State();
}

class _State extends State<SonarrSeriesSearchBarFilterButton> {
  @override
  Widget build(BuildContext context) => LunaCard(
        context: context,
        child: Consumer<SonarrState>(
          builder: (context, state, _) =>
              LunaPopupMenuButton<SonarrSeriesFilter>(
            tooltip: 'Filter Catalogue',
            icon: Icons.filter_alt_outlined,
            onSelected: (result) {
              state.seriesHidingType = result;
              widget.controller.lunaAnimateToStart();
            },
            itemBuilder: (context) =>
                List<PopupMenuEntry<SonarrSeriesFilter>>.generate(
              SonarrSeriesFilter.values.length,
              (index) => PopupMenuItem<SonarrSeriesFilter>(
                value: SonarrSeriesFilter.values[index],
                child: Text(
                  SonarrSeriesFilter.values[index].readable,
                  style: TextStyle(
                    fontSize: LunaUI.FONT_SIZE_SUBTITLE,
                    color: state.seriesHidingType ==
                            SonarrSeriesFilter.values[index]
                        ? LunaColours.accent
                        : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        height: LunaTextInputBar.appBarInnerHeight,
        width: LunaTextInputBar.appBarInnerHeight,
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        color: Theme.of(context).canvasColor,
      );
}
