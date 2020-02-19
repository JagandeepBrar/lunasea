import 'package:flutter/material.dart';
import 'package:lunasea/widgets.dart';

class ConnectionError extends StatelessWidget {
    final Function onTapHandler;

    ConnectionError({
        Key key,
        @required this.onTapHandler,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) => LSGenericMessage(
        text: 'Connection Error',
        showButton: true,
        buttonText: 'Refresh',
        onTapHandler: onTapHandler,
    );
}
