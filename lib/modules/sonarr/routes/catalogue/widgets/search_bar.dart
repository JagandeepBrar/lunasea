import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

class SonarrSeriesSearchBar extends StatefulWidget {
  final ScrollController scrollController;

  const SonarrSeriesSearchBar({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  State<SonarrSeriesSearchBar> createState() => _State();
}

class _State extends State<SonarrSeriesSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = context.read<SonarrState>().seriesSearchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Consumer<SonarrState>(
            builder: (context, state, _) => LunaTextInputBar(
              controller: _controller,
              scrollController: widget.scrollController,
              autofocus: false,
              onChanged: (value) =>
                  context.read<SonarrState>().seriesSearchQuery = value,
              margin: EdgeInsets.zero,
            ),
          ),
        ),
        SonarrSeriesSearchBarFilterButton(controller: widget.scrollController),
        SonarrSeriesSearchBarSortButton(controller: widget.scrollController),
      ],
    );
  }
}
