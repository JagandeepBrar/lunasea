import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/sonarr.dart';

// ignore: non_constant_identifier_names
Widget SonarrAppBar({
    @required BuildContext context,
    @required List<String> profiles,
    @required ScrollController scrollController,
    @required List<Widget> actions,
}) => profiles != null && profiles.length < 2
    ? LunaAppBar(
        context: context,
        title: 'Sonarr',
        actions: actions,
        bottom: _SearchBar(scrollController: scrollController),
        popUntil: null,
    )
    : AppBar(
        title: PopupMenuButton<String>(
            shape: LunaSeaDatabaseValue.THEME_AMOLED.data && LunaSeaDatabaseValue.THEME_AMOLED_BORDER.data
                ? LSRoundedShapeWithBorder()
                : LSRoundedShape(),
            child: Wrap(
                direction: Axis.horizontal,
                children: [
                    Text(
                        'Sonarr',
                        style: TextStyle(
                            fontSize: Constants.UI_FONT_SIZE_HEADER,
                        ),
                    ),
                    LSIcon(
                        icon: Icons.arrow_drop_down,
                    ),
                ],
            ),
            onSelected: (result) => LunaSeaDatabaseValue.ENABLED_PROFILE.put(result),
            itemBuilder: (context) {
                return <PopupMenuEntry<String>>[for(String profile in profiles) PopupMenuItem<String>(
                    value: profile,
                    child: Text(
                        profile,
                        style: TextStyle(
                            fontSize: Constants.UI_FONT_SIZE_SUBTITLE,
                        ),
                    ),
                )];
            },
        ),
        centerTitle: false,
        elevation: 0,
        actions: actions,
        bottom: _SearchBar(scrollController: scrollController),
    );

class _SearchBar extends StatefulWidget implements PreferredSizeWidget {
    final ScrollController scrollController;

    _SearchBar({
        Key key,
        @required this.scrollController,
    }) : super(key: key);

    @override
    Size get preferredSize => Size.fromHeight(62.0);

    @override
    State<_SearchBar> createState() => _State(scrollController: scrollController);
}

class _State extends State<_SearchBar> {
    final TextEditingController _controller = TextEditingController();
    final ScrollController scrollController;

    _State({ @required this.scrollController });

    @override
    void initState() {
        super.initState();
        _controller.text = Provider.of<SonarrLocalState>(context, listen: false).homeSearchQuery;
    }

    @override
    Widget build(BuildContext context) => Consumer<SonarrLocalState>(
        builder: (context, state, widget) => Row(
            children: [
                Expanded(
                    child: LSTextInputBar(
                        controller: _controller,
                        autofocus: false,
                        onChanged: (text, updateController) => _onChange(state, text, updateController),
                        margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 14.0),
                    ),
                ),
                SonarrAppBarHideButton(controller: scrollController),
                SonarrAppBarSortButton(controller: scrollController),
            ],
        ),
    );

    void _onChange(SonarrLocalState state, String text, bool updateController) {
        state.homeSearchQuery = text;
        if(updateController) _controller.text = text;
    }
}
