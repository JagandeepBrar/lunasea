import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

// ignore: non_constant_identifier_names
Widget SonarrReleasesAppBar({
  @required ScrollController scrollController,
}) =>
    LunaAppBar(
      title: 'Releases',
      scrollControllers: [scrollController],
      bottom: _SearchBar(scrollController: scrollController),
    );

class _SearchBar extends StatefulWidget implements PreferredSizeWidget {
  final ScrollController scrollController;

  _SearchBar({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(LunaTextInputBar.appBarHeight);

  @override
  State<_SearchBar> createState() => _State(scrollController: scrollController);
}

class _State extends State<_SearchBar> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController scrollController;

  _State({@required this.scrollController});

  @override
  void initState() {
    super.initState();
    _controller.text = '';
    SchedulerBinding.instance.scheduleFrameCallback((_) {
      Provider.of<SonarrState>(context, listen: false).releasesSearchQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) => Consumer<SonarrState>(
        builder: (context, state, widget) => Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: LunaTextInputBar(
                  controller: _controller,
                  scrollController: scrollController,
                  autofocus: false,
                  onChanged: (value) =>
                      context.read<SonarrState>().releasesSearchQuery = value,
                  margin: LunaTextInputBar.appBarMargin,
                ),
              ),
              SonarrReleasesAppBarFilterButton(controller: scrollController),
              SonarrReleasesAppBarSortButton(controller: scrollController),
            ],
          ),
          height: LunaTextInputBar.appBarHeight,
        ),
      );
}
