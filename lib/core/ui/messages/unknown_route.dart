import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './generic.dart';

class LSUnknownRoute extends StatelessWidget {
    final FluroRouter router;
    final String route;
    final String module;

    LSUnknownRoute({
        Key key,
        @required this.router,
        @required this.route,
        @required this.module,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSGenericMessage(
        text: 'Unknown Route',
        showButton: true,
        buttonText: '$module Home',
        onTapHandler: () => router.navigateTo(context, route, replace: true, clearStack: true),
    );
}
