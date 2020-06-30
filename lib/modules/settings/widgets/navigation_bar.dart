import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';

class SettingsNavigationBar extends StatefulWidget {
    final PageController pageController;

    SettingsNavigationBar({
        Key key,
        @required this.pageController,
    }): super(key: key);

    @override
    State<StatefulWidget> createState() => _State();
}

class _State extends State<SettingsNavigationBar> {
    static const List<String> _navbarTitles = [
        'LunaSea',
        'Modules',
        'System',
    ];

    static const List<IconData> _navbarIcons = [
        CustomIcons.user,
        CustomIcons.modules,
        CustomIcons.code,
    ];

    @override
    Widget build(BuildContext context) => Selector<SettingsModel, int>(
        selector: (_, model) => model.navigationIndex,
        builder: (context, index, _) => LSBottomNavigationBar(
            index: index,
            icons: _navbarIcons,
            titles: _navbarTitles,
            onTap: _navOnTap,
        ),
    );

    Future<void> _navOnTap(int index) async {
        await widget.pageController.animateToPage(
            index,
            duration: Duration(milliseconds: Constants.UI_NAVIGATION_SPEED),
            curve: Curves.easeOutSine,
        );
        Provider.of<SettingsModel>(context, listen: false).navigationIndex = index;
    }
}