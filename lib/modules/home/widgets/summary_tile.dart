import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';

class HomeSummaryTile extends StatelessWidget {
    final String title;
    final String subtitle;
    final IconData icon;
    final int index;
    final String route;
    final bool justPush;

    HomeSummaryTile({
        @required this.title,
        @required this.subtitle,
        @required this.icon,
        @required this.index,
        @required this.route,
        this.justPush = false,
    });

    @override
    Widget build(BuildContext context) => LSCardTile(
        title: LSTitle(text: title),
        subtitle: LSSubtitle(text: subtitle),
        leading: LSIconButton(
            icon: icon,
            color: LSColors.list(index),
        ),
        trailing: LSIconButton(
            icon: Icons.arrow_forward_ios,
        ),
        onTap: () async => justPush
            ? Navigator.of(context).pushNamed(route)
            : Navigator.of(context).pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false),
    );
}