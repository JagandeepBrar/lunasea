import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/lidarr.dart';

class LidarrCatalogueSearchBar extends StatefulWidget {
  final ScrollController scrollController;

  const LidarrCatalogueSearchBar({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  State<LidarrCatalogueSearchBar> createState() => _State();
}

class _State extends State<LidarrCatalogueSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = context.read<LidarrState>().searchCatalogueFilter;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Consumer<LidarrState>(
            builder: (context, state, _) => LunaTextInputBar(
              controller: _controller,
              scrollController: widget.scrollController,
              autofocus: false,
              onChanged: (value) =>
                  context.read<LidarrState>().searchCatalogueFilter = value,
              margin: EdgeInsets.zero,
            ),
          ),
        ),
        LidarrCatalogueHideButton(controller: widget.scrollController),
        LidarrCatalogueSortButton(controller: widget.scrollController),
      ],
    );
  }
}
